resource "azurerm_public_ip" "example" {
  name                = var.public_ip_name      #"acceptanceTestPublicIp1"
  resource_group_name = var.resource_group_name #azurerm_resource_group.example.name
  location            = var.location            #azurerm_resource_group.example.location
  allocation_method   = var.allocation_method   #"Static"
  sku                 = "Standard"

  tags = var.tags
}