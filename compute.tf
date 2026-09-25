module "compute" {
  source = "./modules/compute"

  name_prefix             = "${var.project_name}-${var.environment}"
  location                = azurerm_resource_group.web.location
  resource_group_name     = azurerm_resource_group.web.name
  subnet_id               = module.network.subnet_id
  backend_address_pool_id = module.load_balancer.backend_address_pool_id
  health_probe_id         = module.load_balancer.health_probe_id

  vm_size              = var.vm_size
  instance_count       = var.instance_count
  availability_zones   = var.vm_availability_zones
  admin_username       = var.admin_username
  admin_ssh_public_key = trimspace(file("${path.root}/${var.ssh_public_key_path}"))
  tags                 = azurerm_resource_group.web.tags
}