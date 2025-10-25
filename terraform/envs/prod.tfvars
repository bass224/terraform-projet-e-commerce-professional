


#ici on doit mettre les valeurs concrètes 


#====> Sécurité 
resource_group_keyvault_name ="rg_ecommerce-securite-prod"
location_resource_group_kv ="France Central"
environnement = "prod"


keyvault_name ="myecommercekvprod"
keyvault_sku_name="standard"
keyvault_password_secret_name ="sql-admin-password" 
#======> 


resource_group_name = "my_ecommerce-rg-prod"
location = "France Central"


#Le compte de stockage
storage_acount_name = "myecommercestgprod"
storage_account_replication_type ="LRS"
storage_account_tier ="Standard"


#azure data factory

datafactory_name = "my-datafact-prod"


#Le link service sql database 
ls_sql_database_name = "ls_sql-prod"


#Connexion à la base de données pour le link service 

sql_server_name ="sql-server-ecom-prod"
sql_database_name="ecom"
sql_database_login="bass"

#le link service adls_gen2
ls_alds_gen2_name = "ls_adls_gen2-prod"

#le dataset sql 
ds_sql_name = "ds_sql-prod"


#le nom de la table sql 
table_name_for_dataset = "dbo.orders"