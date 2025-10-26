# terraform-projet-e-commerce
Projet full terraform et azure data factory 


![Terraform](https://img.shields.io/badge/IaC-Terraform-blueviolet)
![Azure](https://img.shields.io/badge/Cloud-Azure-blue)
![DataFactory](https://img.shields.io/badge/Data-Factory-lightblue)


## Objectif 
Mettre en place un pipeline data factory automatisé (terraform + ADF) pour copier les données de la table 'orders' de la base de données azure sql database vers le compte de stockage Azure data lake storage Gen2 (précisemet dans un container landing zone)

## Architecture

- **Azure SQL database** (la source de données)
- **Azure Data factory** (Pour l'orchestration des pipelines)
- **Azure data lake storage Gen2** (Pour le stockage -> Landing zone)
- **Terraform** (pour l'infrascture et la configuration)

## Fonctionnement
1. Avec Terraform, on déploie automatiquement toutes les ressources Azure (le groupe de ressource, le compte de stockage, les container (landing), Azure data factory : les link services, les datasets, la pipeline d'activité de copy, le job schedulé)
2. ADF va exécuter notre pipeline de copy de données de SQL vers Azure data lake storage gen2 
3. Les données sont ainsi exportés au format csv vers la landing zone 

## Lancmeent du projet : 
-  Cloner le repos. 
-  Démarrer az cli et se connecter sur votre portail azure (az login) 
-  Créer une key vault pour éviter d'avoir des mdp en dûr dans des scripts exemple pour crée un keyvault: 
az keyvault secret set --vault-name myecommercekvdev --name "sql-admin-password" --value "MonSuperMotDePasse"
- Puis démarrer terraform et faire terran init, terraform plan et terraform deploy pour déployer les ressources (choisir dev, staging ou prod)
- Une fois déployé, comme je n'ai pas la table orders dans ma base de données, et c'est pas pratique de créer une table 
avec terraform, alors allez dans la base sql qu'on a crée, se loguer (attention peut être autorisé l'ip de la personne qui y va), aller dans editeur de requêtes et lancer le code qui se trouve dans le table_orders.sql (cela créera la table orders)
- Puis après tout sera ok, on pourra teser les link services, datasets, pipeline, trigger et même retrouver les données dans 
le container landing de la landing zone. Et sur ADF, on pourra voir si le job a tourné ou pas, on peut le lancé manuellement si on le souhaite. 


## Structure 
terraform/   
data/  
docs/  


## Envrionnement  
dev  
staging  
prod    

## Trigger
- Exécution automatique tous  les jours à 00:00:00ss

## Auteur
Abdoul Bassity DIALLO / bass224
