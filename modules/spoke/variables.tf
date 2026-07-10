variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "spoke_vnet_name" {
  description = "Name of the spoke virtual network"
  type        = string
}

variable "spoke_address_space" {
  description = "Address space for the spoke virtual network"
  type        = list(string)
}

variable "workload_subnet_prefix" {
  description = "Address prefix for the workload subnet"
  type        = list(string)
}

variable "mgmt_subnet_prefix" {
  description = "Address prefix for the management subnet"
  type        = list(string)
}

variable "hub_vnet_id" {
  description = "ID of the hub virtual network"
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the hub virtual network"
  type        = string
}



variable "remote_spoke_address_space" {
  description = "Address space of the remote spoke network"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}