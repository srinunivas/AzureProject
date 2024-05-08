output "mssql_server_id" {
  value = azurerm_mssql_server.example.id
}

output "user_assigned_identity_id" {
  value = azurerm_user_assigned_identity.example.id
}

output "key_vault_id" {
  value = try(azurerm_key_vault.example[0].id, null)
}

output "key_vault_key_id" {
  value = try(azurerm_key_vault_key.example[0].id, null)
}

output "key_vault_key_name" {
  value = try(azurerm_key_vault_key.example[0].name, null)
}