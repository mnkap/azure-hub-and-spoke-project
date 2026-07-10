variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure Region"
  type        = string
}

variable "vm_name" {
  description = "The name of the Linux Virtual Machine"
  type        = string
}

# This is the crucial variable to accept the Subnet ID

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM (retrieved from Key Vault)"
  type        = string
  sensitive   = true
}

variable "workload_subnet_id" {
  description = "The ID of the Subnet where the VM should be placed"
  type        = string
}