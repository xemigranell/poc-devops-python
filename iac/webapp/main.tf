terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80"
    }    
    random = {
      source  = "hashicorp/azurerm"
      version = ">= 3.5"
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

data "azurerm_key_vault" "keyvault" {
  resource_group_name = data.azurerm_resource_group.rsg.name
  name                = "${var.rsg_name}kvt${var.env}001"
}

data "azurerm_container_registry" "acr" {
  name                = "${var.rsg_name}reg${var.env}001"
  resource_group_name = data.azurerm_resource_group.rsg.name
}