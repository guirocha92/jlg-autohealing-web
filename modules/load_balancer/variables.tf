variable "name_prefix" {
  type        = string
  description = "Project and environment name used in load balancer resource names."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group that will contain the load balancer."
}

variable "location" {
  type        = string
  description = "Azure region for the load balancer resources."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to resources that support them."
  default     = {}
}
