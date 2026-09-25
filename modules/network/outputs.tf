output "subnet_id" {
  description = "Web subnet ID, available after its security group is attached."
  value       = azurerm_subnet.web.id

  depends_on = [azurerm_subnet_network_security_group_association.web]
}
