output "vm_scale_set_name" {
  description = "Name of the Linux virtual machine scale set."
  value       = azurerm_linux_virtual_machine_scale_set.web.name
}

output "autoscale_setting_name" {
  description = "Name of the fixed-capacity autoscale setting."
  value       = azurerm_monitor_autoscale_setting.web.name
}