data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "example" {
  name                        = var.key_vault.name 
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.key_vault.sku_name
  enabled_for_disk_encryption = var.key_vault.enabled_for_disk_encryption
  soft_delete_retention_days  = 7
  purge_protection_enabled    = var.key_vault.purge_protection_enabled
}

resource "azurerm_key_vault_key" "example" {
  name         = "${var.key_vault.name}-key" 
  key_vault_id = azurerm_key_vault.example.id
  key_type     = var.key_vault_key.key_type
  key_size     = var.key_vault_key.key_size

  depends_on = [
    azurerm_key_vault_access_policy.example-user
  ]

  key_opts = var.key_vault_key.key_opts
}

resource "azurerm_disk_encryption_set" "example" {
  count = var.disk_encryption_set_enabled ? 1:0
  name                = var.disk_encryption_set.name
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_key_id    = azurerm_key_vault_key.example.id
  encryption_type     = var.disk_encryption_set.encryption_type

  auto_key_rotation_enabled = var.disk_encryption_set.auto_key_rotation_enabled

  identity {
    type = var.disk_encryption_set.identity_type
  }
}

resource "azurerm_key_vault_access_policy" "example-disk" {
  count = var.disk_kv_access_policy_enabled ? 1 : 0
  key_vault_id = azurerm_key_vault.example.id

  tenant_id = azurerm_disk_encryption_set.example[0].identity[0].tenant_id
  object_id = azurerm_disk_encryption_set.example[0].identity[0].principal_id

  key_permissions = var.disk_kv_access_policy_key_permissions
  secret_permissions = ["Get", "List"]
  storage_permissions = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "RegenerateKey", "Restore", "Set"]
}

resource "azurerm_key_vault_access_policy" "example-user" {
  count = var.user_kv_access_policy_enabled ? 1 : 0
  key_vault_id = azurerm_key_vault.example.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id
  key_permissions = var.user_kv_access_policy_key_permissions
  secret_permissions = ["Get", "List"]
  storage_permissions = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "RegenerateKey", "Restore", "Set"]
}

resource "azurerm_role_assignment" "example-disk" {
  count = var.role_assignment_enabled ? 1:0
  scope                = azurerm_key_vault.example.id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_disk_encryption_set.example[0].identity[0].principal_id
}