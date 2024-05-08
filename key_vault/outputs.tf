output "key_vault_id" {
  value = azurerm_key_vault.example.id
}

output "key_vault_key_id" {
  value = azurerm_key_vault_key.example.id
}

output "key_vault_key_name" {
  value = azurerm_key_vault_key.example.name
}

output "disk_encryption_set_id" {
    value = try(azurerm_disk_encryption_set.example[0].id, "")
}