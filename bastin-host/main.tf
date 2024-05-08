resource "azurerm_bastion_host" "example" {
  name                = var.bastion_host_name   #"examplebastion"
  location            = var.location            #azurerm_resource_group.example.location
  resource_group_name = var.resource_group_name #azurerm_resource_group.example.name
  sku                 = "Standard"

  ip_configuration {
    name                 = var.ip_configuration_name #"configuration"
    subnet_id            = var.subnet_id             #azurerm_subnet.example.id
    public_ip_address_id = var.public_ip_address_id  #azurerm_public_ip.example.id
  }
}
