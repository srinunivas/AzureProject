output "public_ip" {
  value = azurerm_public_ip.example.id
}

output "public_ip_name" {
  value = azurerm_public_ip.example.name
}

output "ip_address" {
  value = azurerm_public_ip.example.ip_address
}