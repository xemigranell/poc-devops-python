terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80"
    }    
  }
}

provider "azurerm" {
  features {}
}

/////////////////
// DATASOURCES //
/////////////////

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rsg" {
  name = "${var.rsg_name}-rsg-weu1-${var.env}"
}
