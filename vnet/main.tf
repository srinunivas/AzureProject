resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name

  location            = var.location
  resource_group_name = var.rg_name

  address_space = var.address_space
  dns_servers   = var.dns_servers

  tags = var.tags
}
