
#Contient Les ressources et la logique principale 
#But de construire l'infrastructure 

#====> sécurité =====
#Création d'un resource group pour les keyvault 

resource "azurerm_resource_group" "kv" {
    name = var.resource_group_keyvault_name
    location = var.location_resource_group_kv
    
    tags = {
      environnement =var.environnement

    }
}

# Qui suis-je ? (tenant/object id du principal qui exécute Terraform)
data "azurerm_client_config" "current" {

}
# Création d'un key vault 

resource "azurerm_key_vault" "kv" {
  name= var.keyvault_name
  location = azurerm_resource_group.kv.location
  resource_group_name = azurerm_resource_group.kv.name
  sku_name = var.keyvault_sku_name
  tenant_id = data.azurerm_client_config.current.tenant_id

  # pas obligatoire mais récommandé
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true
  enable_rbac_authorization   = true   # RBAC (recommandé)
}


# Donner le droit d'écrire des secrets au principal Terraform
resource "azurerm_role_assignment" "kv_secrets_officer" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

# Secret du mot de passe SQL (création)
# NOTE: la valeur est fournie au runtime via -var "sql_admin_password=..."
# ----------------------------------------
resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.keyvault_password_secret_name
  value        = var.sql_database_password
  key_vault_id = azurerm_key_vault.kv.id
  depends_on   = [azurerm_role_assignment.kv_secrets_officer]
  content_type = "password"
}

#on utilise data pour lire ou récupérer un objet déjà existant 

data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.keyvault_password_secret_name
  key_vault_id = azurerm_key_vault.kv.id
}


#===> fin sécurité 




#Création d'une resource group pour les ressources classiques 

resource "azurerm_resource_group" "rg"{
    name = var.resource_group_name
    location = var.location

    tags = {
      environnement =var.environnement

    }
}


#Crétaion du compte de stockage 

resource "azurerm_storage_account" "stg" {
    name =var.storage_acount_name
    resource_group_name = azurerm_resource_group.rg.name
    account_replication_type = var.storage_account_replication_type
    location = azurerm_resource_group.rg.location
    account_tier = var.storage_account_tier

    tags = {
      environnement =var.environnement

    }

}

#----> création de la database : d'abord le server sql qui va hébergé la base
# puis la database et autoriser notre pc et les ressources azure comme adf à y accéder 



resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_database_login
  administrator_login_password = var.sql_database_password

  tags = {
    environment = var.environnement
  }
}

#la database 
resource "azurerm_mssql_database" "sql_db" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.sql_server.id
  sku_name       = "S0" # ou Basic, P1, GP_Gen5_2 etc.
  max_size_gb    = 10
  zone_redundant = false

  tags = {
    environment = var.environnement
  }
}

#Puis on autorise notre pc à se connecter à la base (faut ajouter les règles de pare-feu ci dessous sinon ça marchera pas )
#car par defaut azure bloque tous les accès externe pour des raisons de sécurité

# autoriser ton PC à se connecter au serveur SQL

resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
  name             = "allow-my-ip"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "92.151.25.36"   # ton IP publique actuelle
  end_ip_address   = "92.151.25.36"   # même IP pour une seule adresse
}


#si on veut autoriser les services azure comme azure data factory à se connecter sur la base aussi 

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "allow-azure-services"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}







#Création du azure datafactory 

resource "azurerm_data_factory" "mydatafact" {
  name= var.datafactory_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
      environnement =var.environnement

    }

}

#création du link service sql database 

#il va aller lire le mot de basse crée dans le keyvault 

resource "azurerm_data_factory_linked_service_azure_sql_database" "ls_sql" {
  name = var.ls_sql_database_name
  data_factory_id = azurerm_data_factory.mydatafact.id
  #connection_string = "Server=tcp:${var.sql_server_name}.database.windows.net,1433;Database=${var.sql_database_name};User ID=${var.sql_database_login};Password=${var.sql_database_password};Encrypt=true;Connection Timeout=30;"
  connection_string = "Server=tcp:${var.sql_server_name}.database.windows.net,1433;Database=${var.sql_database_name};User ID=${var.sql_database_login};Password=${azurerm_key_vault_secret.sql_admin_password.value};Encrypt=true;Connection Timeout=30;"
}


#===> Création du link service adls gen2 

resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "ls_adls" {
  name = var.ls_alds_gen2_name
  data_factory_id = azurerm_data_factory.mydatafact.id
  use_managed_identity = true
  url ="https://${var.storage_acount_name}.dfs.core.windows.net/"
  
}

#===> Création du dataset source 

resource "azurerm_data_factory_dataset_sql_server_table" "ds_sql" {
  name = var.ds_sql_name
  data_factory_id = azurerm_data_factory.mydatafact.id
  linked_service_name = azurerm_data_factory_linked_service_azure_sql_database.ls_sql.name

  table_name = var.table_name_for_dataset
}

#Création du dataset destination 
resource "azurerm_resource_group_template_deployment" "ds_adls_gen2" {
  name                = var.ds_adls_deployement_name
  resource_group_name = azurerm_resource_group.rg.name
  deployment_mode     = var.ds_adls_deployment_mode

  template_content = templatefile("${path.module}/../adf/${var.ds_adls_json_file}.json", {})

  parameters_content = jsonencode({
    dataFactoryName = {
      value = azurerm_data_factory.mydatafact.name
    }

    adlsLinkedServiceName = {
      value = azurerm_data_factory_linked_service_data_lake_storage_gen2.ls_adls.name
      # ^ adapte le type/nom exact de ta ressource linked service
    }
  })

  depends_on = [
    azurerm_data_factory.mydatafact
  ]
}


#===> création du pipeline d'activité de copy 

resource "azurerm_data_factory_pipeline" "pl_copy_sql_to_adls" {
  name            = var.pipeline_name
  data_factory_id = azurerm_data_factory.mydatafact.id
  description     = "Pipeline qui copie les données SQL vers ADLS."

  activities_json = templatefile("${path.module}/../adf/${var.pipeline_file}.json.tmpl", {
    activity_name  = var.activity_name
    sql_table      = var.sql_table
    input_dataset  = var.ds_sql_name
    output_dataset = var.ds_adls_gen2
  })
}
