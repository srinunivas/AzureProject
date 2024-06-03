resource "azurerm_virtual_network" "vnet" {
  name = "${var.org_name}-${var.project_name}-${var.env}-${var.region}-${var.vnet_name}"

  location            = var.location
  resource_group_name = var.rg_name

  address_space = var.address_space
  dns_servers   = var.dns_servers

  tags = var.tags
}
