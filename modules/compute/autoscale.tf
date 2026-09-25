resource "azurerm_monitor_autoscale_setting" "web" {
  name                = "autoscale-${var.name_prefix}"
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.web.id
  enabled             = true

  profile {
    name = "fixed-capacity"

    capacity {
      default = tostring(var.instance_count)
      minimum = tostring(var.instance_count)
      maximum = tostring(var.instance_count)
    }
  }

  tags = var.tags
}