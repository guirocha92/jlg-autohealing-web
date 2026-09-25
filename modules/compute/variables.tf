variable "name_prefix" {
  description = "Prefix used for compute resource names."
  type        = string
}

variable "location" {
  description = "Azure region where compute resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group containing the compute resources."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet used by the VM Scale Set."
  type        = string
}

variable "backend_address_pool_id" {
  description = "ID of the load balancer backend address pool."
  type        = string
}

variable "health_probe_id" {
  description = "ID of the load balancer health probe used for automatic repairs."
  type        = string
}

variable "vm_size" {
  description = "Azure VM size used by the scale set."
  type        = string
}

variable "instance_count" {
  description = "Number of web instances maintained by the scale set."
  type        = number

  validation {
    condition     = var.instance_count >= 2
    error_message = "instance_count must be at least 2 to provide N+1 capacity."
  }
}

variable "availability_zones" {
  description = "Availability zones used by the scale set."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two availability zones must be provided."
  }
}

variable "admin_username" {
  description = "Administrator username configured on the Linux instances."
  type        = string
}

variable "admin_ssh_public_key" {
  description = "SSH public key configured on the Linux instances."
  type        = string
}

variable "tags" {
  description = "Tags applied to the compute resources."
  type        = map(string)
}