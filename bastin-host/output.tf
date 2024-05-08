output "bastion_host_ip" {
  value = azurerm_bastion_host.example.id
}

output "dns_name" {
  value = azurerm_bastion_host.example.dns_name
}