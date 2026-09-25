module "load_balancer" {
  source = "./modules/load_balancer"

  name_prefix         = "${var.project_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.web.name
  location            = azurerm_resource_group.web.location
  tags                = azurerm_resource_group.web.tags

  public_ip_zones = var.public_ip_zones
}
