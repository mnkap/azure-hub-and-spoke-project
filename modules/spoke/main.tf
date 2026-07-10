# Spoke Virtual Network
resource "azurerm_virtual_network" "spoke" {
  name                = var.spoke_vnet_name
  address_space       = var.spoke_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Spoke Subnets
resource "azurerm_subnet" "workload" {
  name                 = "snet-workload"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = var.workload_subnet_prefix
}

resource "azurerm_subnet" "management" {
  name                 = "snet-management"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = var.mgmt_subnet_prefix
}

# VNet Peering: Hub to Spoke
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = "peer-${var.hub_vnet_name}-to-${var.spoke_vnet_name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.hub_vnet_name
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}

# VNet Peering: Spoke to Hub
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = "peer-${var.spoke_vnet_name}-to-${var.hub_vnet_name}"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = var.hub_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
}

# Route Table for Spoke
resource "azurerm_route_table" "spoke" {
  name                = "rt-${var.spoke_vnet_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}


# Associate Route Table to Spoke Subnets
resource "azurerm_subnet_route_table_association" "workload" {
  subnet_id      = azurerm_subnet.workload.id
  route_table_id = azurerm_route_table.spoke.id
}

resource "azurerm_subnet_route_table_association" "management" {
  subnet_id      = azurerm_subnet.management.id
  route_table_id = azurerm_route_table.spoke.id
}