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
