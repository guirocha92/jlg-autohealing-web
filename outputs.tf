output "website_public_ip_address" {
  description = "Public IP address visitors can use after deployment."
  value       = module.load_balancer.public_ip_address
}

output "website_url" {
  description = "HTTP URL for the NGINX website after deployment."
  value       = "http://${module.load_balancer.public_ip_address}"
}

output "resource_group_name" {
  description = "Name of the resource group containing the web tier."
  value       = azurerm_resource_group.web.name
}

output "vm_scale_set_name" {
  description = "Name of the web virtual machine scale set."
  value       = module.compute.vm_scale_set_name
}

output "autoscale_setting_name" {
  description = "Name of the capacity protection setting."
  value       = module.compute.autoscale_setting_name
}