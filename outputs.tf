# Outputs
output "hub_vnet_id" {
  description = "The ID of the Hub Virtual Network"
  value       = module.hub.hub_vnet_id
}

output "spoke1_vnet_id" {
  description = "The ID of Spoke 1 Virtual Network"
  value       = module.spoke1.spoke_vnet_id
}

