variable "location" {
  description = "The Azure region where resources will be created"
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "rg-hub-spoke-network"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    environment = "production"
    project     = "hub-spoke-network"
    terraform   = "true"
  }
}

variable "admin_password" {
  description = "Admin password for the VM (retrieved from Key Vault)"
  type        = string
  sensitive   = true
}