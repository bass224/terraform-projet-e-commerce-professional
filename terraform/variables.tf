
#Contient : Les définitions de variables (nom, type, description)
# but de rendre le code réutilisable



#======> sécurité 

variable "resource_group_keyvault_name" {
  description = "Le nom du resource group pour les keyvault"
  type = string
}
variable "location_resource_group_kv" {
    description = "la location du resource group pour le kv"
    type = string
  
}

variable "keyvault_name" {
  description = "Nom du key valut qu'on souhaite crée "
  type = string
}

variable "keyvault_sku_name" {
  description = "le sku name"
  type = string
  default = "standard"
}

variable "keyvault_password_secret_name" {
  description = "Nom du secret Key Vault qui contient le mdp"
  type        = string
  default     = "sql-admin-password"
}



#=======> Fin sécurité 

variable "resource_group_name" {
    description = "Nom du resource group"
    type = string
}

variable "location" {
  description = "Région Azure"
  type = string
  default = "France Central"
}

variable "environnement" {
  description = "Type d'environnement (dev, staging ou prod)"
  type = string
}

variable "storage_acount_name" {
  description = "Le nom du compte de stockage"
  type = string
}

variable "storage_account_replication_type" {
  description = "le type de replication"
  type = string
  default = "LRS"
}


variable "storage_account_tier" {
  description = "le account tier "
  type = string
  default = "Standard"
}


variable "datafactory_name" {
  description = "Le nom de la ressource azure data factory"
  type = string
}


variable "ls_sql_database_name" {
  description = "Le nom du link service pou la base de données sql"
  type = string
}

#on va créer des variables pour le nom du sql server,  de la base données, le login et le mdp qui sont nécessaire dans la connection_string
#pour le link service

variable "sql_server_name" {
  description = "Le nom du server sql qui va hébergé la base de donnés"
  type = string
}

variable "sql_database_name" {
    description = "Le nom de la base de données sql"
    type = string
  
}

variable "sql_database_login" {
  description = "Votre login pour se connecter à la base de données"
  type = string
}

variable "sql_database_password" {
  description = "Votre mot de passe de connexion à la base de données"
  type = string
  sensitive = true
}

#création link service pour le ADLS Gen2

variable "ls_alds_gen2_name" {
  description = "Le nom du link service pour le Azure datalake storage gen2"
  type = string
}

#création du datasets source 

variable "ds_sql_name" {
  description = "Le nom du dataset source (sql database)"
  type = string
}

#Nom de la table qu'on requete 

variable "table_name_for_dataset" {
  description = "le nom de la table sql qu'on va requeté pour le dataset"
  type = string
}


#création du dataset de destination adls gen2

variable "ds_adls_deployement_name" {
  description = "Le nom du deployement pour le datastes destination"
  type = string
}

variable "ds_adls_deployment_mode" {
  description = "Le mode de deploiement"
  type = string
  default = "Incremental"
}

variable "ds_adls_json_file" {
  description = "Le fichier json du dataset à deployer"
  type = string
  default = "dataset_adls"
}

