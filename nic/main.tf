resource "azurerm_network_interface" "nic" {
  name                = var.network_interface_name #"nic_ubn-01"
  location            = var.location               #azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name    #azurerm_resource_group.rg.name

  ip_configuration {
    name                          = var.ip_configuration_name         #"nic_ubn-01-configuration"
    subnet_id                     = var.subnet_id                     #azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation #"Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
  tags = var.tags
}