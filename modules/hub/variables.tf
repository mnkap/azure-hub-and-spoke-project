variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the hub virtual network"
  type        = string
  default     = "vnet-hub"
}

variable "hub_address_space" {
  description = "Address space for the hub virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "gateway_subnet_prefix" {
  description = "Address prefix for the gateway subnet"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}


variable "bastion_subnet_prefix" {
  description = "Address prefix for the bastion subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "mgmt_subnet_prefix" {
  description = "Address prefix for the management subnet"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}