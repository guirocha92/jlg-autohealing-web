output "backend_address_pool_id" {
  description = "ID of the load balancer Backend address pool"
  value       = azurerm_lb_backend_address_pool.web.id
  depends_on = [
    azurerm_lb_outbound_rule.web
  ]
}

output "public_ip_address" {
  description = "Public IPv4 address assigned to the load balancer frontend."
  value       = azurerm_public_ip.web.ip_address
}

output "health_probe_id" {
  description = "ID of the HTTP health probe used by VMSS automatic repairs."
  value       = azurerm_lb_probe.http.id
}