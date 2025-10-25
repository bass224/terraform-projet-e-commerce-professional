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

## Structure 
terraform/   
data/  
docs/  


## Envrionnement  
dev  
staging  
prod    

## Trigger
- Exécution automatique tous  les jours à hh:mm:ss

## Auteur
Abdoul Bassity DIALLO / bass224
