variable "project_name" {
  type        = string
  description = "Short project name used in resource names and tags."
  default     = "jlg-web"
}

variable "environment" {
  type        = string
  description = "Environment name used to distinguish this deployment."
  default     = "lab"
}

variable "location" {
  type        = string
  description = "Azure region for the lab."
  default     = "australiaeast"
}

variable "public_ip_zones" {
  description = "Availability zones for the load balancer public IP."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "vm_size" {
  description = "Azure VM size used by the web scale set."
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "instance_count" {
  description = "Number of web instances maintained by the scale set."
  type        = number
  default     = 2
}

variable "vm_availability_zones" {
  description = "Availability zones used by the web scale set."
  type        = list(string)
  default     = ["1", "3"]
}

variable "admin_username" {
  description = "Administrator username configured on the Linux instances."
  type        = string
  default     = "azureadmin"
}

variable "ssh_public_key_path" {
  description = "Repository-relative path to the SSH public key."
  type        = string
  default     = "keys/jlg_vmss_ed25519.pub"
}