terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Or whichever version you are currently using
    }
  }

  # Add this backend block right here:
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "statestorage2026" # Use your unique name here
    container_name       = "tfstate"
    key                  = "hub-and-spoke.tfstate" # The name of your state file blob
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "hub_spoke" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Deploy the Hub VNet
module "hub" {
  source = "./modules/hub"

  resource_group_name = azurerm_resource_group.hub_spoke.name
  location            = azurerm_resource_group.hub_spoke.location
  hub_vnet_name       = "vnet-hub"
  hub_address_space   = ["10.0.0.0/16"]

  gateway_subnet_prefix  = ["10.0.0.0/24"]
  bastion_subnet_prefix  = ["10.0.1.0/24"]
  mgmt_subnet_prefix     = ["10.0.2.0/24"]

  tags = var.tags
}



# Define the spoke networks
module "spoke1" {
  source = "./modules/spoke"

  resource_group_name    = azurerm_resource_group.hub_spoke.name
  location               = azurerm_resource_group.hub_spoke.location
  spoke_vnet_name        = "vnet-spoke1"
  spoke_address_space    = ["10.1.0.0/16"]
  workload_subnet_prefix = ["10.1.0.0/24"]
  mgmt_subnet_prefix     = ["10.1.1.0/24"]

  hub_vnet_id          = module.hub.hub_vnet_id
  hub_vnet_name        = module.hub.hub_vnet_name

  tags = var.tags

}


module "linux_app_server" {
  source = "./modules/vms"

  vm_name             = "app-server-01"
  resource_group_name = azurerm_resource_group.hub_spoke.name
  location            = azurerm_resource_group.hub_spoke.location
  
  # Grab the output from the spoke module and pass it here!
  workload_subnet_id  = module.spoke1.workload_subnet_id
  
  admin_username      = "adminuser"
  admin_password      = var.admin_password
}

