resource "azurerm_network_interface" "nic" {
  name                = "${var.org_name}-${var.project_name}-${var.env}-${var.region}-${var.network_interface_name}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = var.public_ip_address_id
  }
  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "example" {
  count                     = var.associate_nsg ? 1 : 0
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = var.network_security_group_id
}