terraform {
   required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
  
  backend "azurerm" {
    resource_group_name  = "tfrg"
    storage_account_name = "tfstrg39"
    container_name       = "tfstrgcontainer"
    key                  = "terraformgithubexample.tfstate"
  }
}
 
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}
 
data "azurerm_client_config" "current" {}
 
#Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "terra-rg"
  location = "eastus2"
}
 
#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "terra-vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.rg.name
}
 
# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}
  
