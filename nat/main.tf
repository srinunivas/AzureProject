resource "azurerm_nat_gateway" "example" {
  name                    = var.nat_gateway_name        
  location                = var.location                
  resource_group_name     = var.resource_group_name     
  sku_name                = var.sku_name                
  idle_timeout_in_minutes = var.idle_timeout_in_minutes 
  zones                   = var.zones                   
  tags                    = var.tags
}

resource "azurerm_subnet_nat_gateway_association" "example" {
  for_each = var.nat_association_subnet_ids
  subnet_id      = each.value
  nat_gateway_id = azurerm_nat_gateway.example.id

  depends_on = [ azurerm_nat_gateway.example ]
}