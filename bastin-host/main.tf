resource "azurerm_bastion_host" "example" {
  name                = "${var.org_name}-${var.project_name}-${var.env}-${var.region}-${var.bastion_host_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  ip_configuration {
    name                 = var.ip_configuration_name
    subnet_id            = var.subnet_id
    public_ip_address_id = var.public_ip_address_id
  }
}
