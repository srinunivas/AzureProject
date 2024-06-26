resource "azurerm_storage_account" "storage_Account" {
  name                          = var.storageaccount.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.storageaccount.account_tier
  account_replication_type      = var.storageaccount.account_replication_type
  public_network_access_enabled = var.storageaccount.public_network_access_enabled
  enable_https_traffic_only     = var.storageaccount.enable_https_traffic_only
  identity {
    type         = var.storageaccount.identity_type
    identity_ids = var.storageaccount.identity_ids
  }

  tags = var.tags
  lifecycle {
    ignore_changes = [
      customer_managed_key
    ]
  }
}

resource "azurerm_storage_container" "data" {
  for_each              = var.storagecontioner
  name                  = each.value.name
  storage_account_name  = azurerm_storage_account.storage_Account.name
  container_access_type = each.value.container_access_type

  depends_on = [azurerm_storage_account.storage_Account, azurerm_role_assignment.blob_writer_assignment]
}

resource "azurerm_storage_blob" "sample1" {
  for_each               = var.storage_blob
  name                   = each.value.name
  storage_account_name   = azurerm_storage_account.storage_Account.name
  storage_container_name = each.value.storage_container_name
  type                   = each.value.type
  source                 = each.value.source
  depends_on = [
    azurerm_storage_account.storage_Account, azurerm_storage_container.data, azurerm_role_assignment.blob_writer_assignment
  ]
}

resource "azurerm_storage_account_customer_managed_key" "example" {
  count                     = var.customer_managed_key.enabled ? 1 : 0
  storage_account_id        = azurerm_storage_account.storage_Account.id
  key_vault_id              = var.customer_managed_key.key_vault_id
  key_name                  = var.customer_managed_key.key_name
  user_assigned_identity_id = var.customer_managed_key.user_assigned_identity_id

  depends_on = [azurerm_role_assignment.blob_writer_assignment]
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "blob_writer_assignment" {
  scope                = azurerm_storage_account.storage_Account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
