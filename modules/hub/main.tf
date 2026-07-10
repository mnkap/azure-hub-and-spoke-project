# Hub Virtual Network
resource "azurerm_virtual_network" "hub" {
  name                = var.hub_vnet_name
  address_space       = var.hub_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Hub Subnets
resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.gateway_subnet_prefix
}


resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.bastion_subnet_prefix
}

resource "azurerm_subnet" "management" {
  name                 = "snet-management"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = var.mgmt_subnet_prefix
}