output "name" {
  description = "Name of the subnet that is created"
  value       = azurerm_subnet.sub.name
}

output "id" {
  description = "Id of the subnet that is created"
  value       = azurerm_subnet.sub.id
}