
#Contient : Les informations exportées (nom, id, IP, etc.)
#but : Fournir des infos aux autres modules / pipeline

#ici on va afficher ce qu'on veut que terraform nous affiche à la fin 
#attention, on veut afficher ce que terraform a réellement crée pas ce que nous on lui dit juste d'afficher (privilegier azurerm_xxx.qlq chose au lieu de var.quelque chose)
#car c'est plus fiable qu'il affiche ce qu'il a réellement crée que de nous affiché ce qu'on lui dit juste d'afficher (car c'est moins fiable)

#======> Sécurité avec key vault ====
output "resource_group_keyvault_name" {
  description = "Nom du resource group pour le keyvault crée"
  value = azurerm_resource_group.kv.name
  
}

output "resource_group_keyvault_id" {
  value = azurerm_resource_group.kv.id
}

output "sql_password_secret_id" {
  value       = azurerm_key_vault_secret.sql_admin_password.id
  description = "ID du secret du mdp SQL"
  sensitive   = true
}

#=====> les ressources classiques 

output "resource_groupe_name" {
  description = "Nom du resource group crée"
  value = azurerm_resource_group.rg.name
  
}

output "resource_groupe_id" {
  value = azurerm_resource_group.rg.id
}



output "storage_acount_name" {
  description = "Nom du compte de stockage crée"
  value = azurerm_storage_account.stg.name
}

output "storage_acount_id" {
    description = "ID du compte de stockage crée"
    value = azurerm_storage_account.stg.id
  
}

output "datafactory_name" {
    description = "Le nom du azure data factory crée"
    value = azurerm_data_factory.mydatafact.name
  
}

output "ls_sql_name" {
  description = "le nom du link service de la base sql crée"
  value = azurerm_data_factory_linked_service_azure_sql_database.ls_sql.name
}

#output link service alds_gen2

output "ls_alds_gen2_name" {
    description = "le nom du link service du adls_gen2 crée"
    value = azurerm_data_factory_linked_service_data_lake_storage_gen2.ls_adls.name
  
}

#output du dataset source 

output "ds_sql_name" {
  description = "le nom du dataset sql crée "
  value = azurerm_data_factory_dataset_sql_server_table.ds_sql.name
}

output "ds_adls_deployment_mode" {
  description = "le mode de deploiement"
  value = azurerm_resource_group_template_deployment.ds_adls_gen2.deployment_mode
}

