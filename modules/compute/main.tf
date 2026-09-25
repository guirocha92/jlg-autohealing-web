resource "azurerm_linux_virtual_machine_scale_set" "web" {
  name                = "vmss-${var.name_prefix}"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku       = var.vm_size
  instances = var.instance_count
  zones     = var.availability_zones

  admin_username                  = var.admin_username
  disable_password_authentication = true

  health_probe_id = var.health_probe_id
  zone_balance    = false
  overprovision   = false
  upgrade_mode    = "Manual"

  custom_data = filebase64("${path.module}/cloud-init.yaml")

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 64
  }

  network_interface {
    name    = "nic-${var.name_prefix}"
    primary = true

    ip_configuration {
      name      = "ipconfig-web"
      primary   = true
      subnet_id = var.subnet_id

      load_balancer_backend_address_pool_ids = [
        var.backend_address_pool_id
      ]
    }
  }

  automatic_instance_repair {
    enabled      = true
    action       = "Replace"
    grace_period = "PT10M"
  }

  tags = var.tags
}