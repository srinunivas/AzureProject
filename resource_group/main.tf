resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name #"example"
  location = var.location            #"West Europe"
}