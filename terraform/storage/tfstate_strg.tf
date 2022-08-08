terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tfstate_rg" {
  name     = var.RG_Name
  location = var.Strg_Acc_Location
}

resource "azurerm_storage_account" "tfstate_strg_acc" {
  name                     = var.Strg_Acc_Name
  resource_group_name      = azurerm_resource_group.tfstate_rg.name
  location                 = azurerm_resource_group.tfstate_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstate_container" {
  name                  = var.Strg_Acc_Container_Name
  storage_account_name  = azurerm_storage_account.tfstate_strg_acc.name
  container_access_type = "blob"
}