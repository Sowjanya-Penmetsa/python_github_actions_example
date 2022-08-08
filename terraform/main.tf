provider "azurerm" {
  version = "=2.0.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = var.RG_Name
    storage_account_name = var.Strg_Acc_Name
    container_name       = var.Strg_Acc_Container_Name
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "web_app_rg" {
  name     = "web_app_rg"
  location = var.Strg_Acc_Location
  
}

resource "azurerm_app_service_plan" "web_app_service_plan" {  
  name                = "web_app_service_plan"  
  location            = azurerm_resource_group.web_app_rg.location  
  resource_group_name = azurerm_resource_group.web_app_rg.name  
  
  sku {  
    tier = "Standard"  
    size = "S1"  
  }  
}  
  
resource "azurerm_app_service" "web_app_service" {  
  name                = "web_app_service"  
  location            =  azurerm_resource_group.web_app_rg.location  
  resource_group_name = azurerm_resource_group.web_app_rg.name 
  app_service_plan_id = azurerm_app_service_plan.web_app_service_plan.id  
  
  app_settings = {  
    "DeviceName" = "SampleDevice",  
    "DeviceId" = "2"  
  }  
}
