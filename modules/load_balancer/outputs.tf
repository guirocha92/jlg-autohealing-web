output "backend_address_pool_id" {
  description = "Backend pool ID used to connect the web scale set to the load balancer."
  value       = azurerm_lb_backend_address_pool.web.id
}

output "public_ip_address" {
  description = "Public IPv4 address assigned to the load balancer frontend."
  value       = azurerm_public_ip.web.ip_address
}
