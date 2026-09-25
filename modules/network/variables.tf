variable "name_prefix" {
  type        = string
  description = "Project and environment name used in network resource names."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group that will contain the network."
}

variable "location" {
  type        = string
  description = "Azure region for the network resources."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the virtual network and network security group."
  default     = {}
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Private IP address ranges available to the virtual network."
  default     = ["10.20.0.0/16"]
}

variable "web_subnet_cidr" {
  type        = string
  description = "Private IP address range reserved for the web instances."
  default     = "10.20.1.0/24"
}
