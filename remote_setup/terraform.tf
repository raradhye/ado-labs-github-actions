##################################################################################
# TERRAFORM CONFIG
##################################################################################
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.35.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.6.0"
    }
  }
}


##################################################################################
# PROVIDERS
##################################################################################

provider "azurerm" {
  features {}
}
