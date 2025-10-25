
#Contient : Les versions minimales
#but : Garantir la compatibilité


terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }

  }
}
