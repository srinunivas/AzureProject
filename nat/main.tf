resource "azurerm_nat_gateway" "example" {
  name                    = var.nat_gateway_name        #"nat-Gateway"
  location                = var.location                #azurerm_resource_group.example.location
  resource_group_name     = var.resource_group_name     #azurerm_resource_group.example.name
  sku_name                = var.sku_name                #"Standard"
  idle_timeout_in_minutes = var.idle_timeout_in_minutes #10
  zones                   = var.zones                   #["1"]
  tags                    = var.tags
}

resource "azurerm_subnet_nat_gateway_association" "example" {
  for_each = var.nat_association_subnet_ids
  subnet_id      = each.value
  nat_gateway_id = azurerm_nat_gateway.example.id

  depends_on = [ azurerm_nat_gateway.example ]
}