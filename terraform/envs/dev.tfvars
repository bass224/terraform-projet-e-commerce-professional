
#ici on doit mettre les valeurs concrètes 

#====> Sécurité 
resource_group_keyvault_name ="rg_ecommerce-securite-dev"
location_resource_group_kv ="France Central"
environnement = "dev"

keyvault_name ="myecommercekvdev"
keyvault_sku_name="standard"
keyvault_password_secret_name ="sql-admin-password" 

#======> fin sécurité


#====> Les autres ressources 


resource_group_name = "my_ecommerce-rg-dev"
location = "France Central"

#le compte de stockage
storage_acount_name = "myecommercestgdev"
storage_account_replication_type ="LRS"
storage_account_tier ="Standard"


#azure data factory

datafactory_name = "my-datafact-dev"

#Le link service sql database 
ls_sql_database_name = "ls_sql-dev"

#Connexion à la base de données pour le link service 

sql_server_name ="sql-server-ecom-dev"
sql_database_name="ecom"
sql_database_login="bass"

#le link service adls_gen2
ls_alds_gen2_name = "ls_adls_gen2-dev"

#le dataset sql 
ds_sql_name = "ds_sql-dev"

#le nom de la table sql 
table_name_for_dataset = "dbo.orders"

#le deploiement et le dataset destination 

ds_adls_deployement_name ="adls_deploy"
ds_adls_deployment_mode ="Incremental"
ds_adls_json_file ="dataset_adls"


#le dataset destination adls 
ds_adls_gen2 = "ds_adls_gen2-dev"

#nom du fichier json qui va créer le pipeline 

pipeline_file = "pipeline_copy"