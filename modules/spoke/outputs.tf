output "spoke_vnet_id" {
  description = "The ID of the Spoke Virtual Network"
  value       = azurerm_virtual_network.spoke.id
}

output "spoke_address_space" {
  description = "The address space of the Spoke Virtual Network"
  value       = var.spoke_address_space
}

output "workload_subnet_id" {
  description = "The ID of the Workload Subnet"
  value       = azurerm_subnet.workload.id
}

output "management_subnet_id" {
  description = "The ID of the Management Subnet"
  value       = azurerm_subnet.management.id
}

output "route_table_id" {
  description = "The ID of the Route Table"
  value       = azurerm_route_table.spoke.id
}