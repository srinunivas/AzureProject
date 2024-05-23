resource "azurerm_public_ip" "example" {
  name                = var.public_ip_name     
  resource_group_name = var.resource_group_name 
  location            = var.location            
  allocation_method   = var.allocation_method   
  sku                 = "Standard"

  tags = var.tags
}