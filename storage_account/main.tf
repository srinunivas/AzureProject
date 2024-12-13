resource "azurerm_storage_account" "storage_Account" {
  name                          = var.storageaccount.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.storageaccount.account_tier
  account_replication_type      = var.storageaccount.account_replication_type
  public_network_access_enabled = var.storageaccount.public_network_access_enabled
  #https_traffic_only_enabled    = var.storageaccount.https_traffic_only_enabled
  is_hns_enabled                = var.storageaccount.is_hns_enabled
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

resource "azapi_update_resource" "enablesftp" {
  count = var.enable_sftp ? 1 : 0
  type = "Microsoft.Storage/storageAccounts@2021-09-01"
  resource_id = azurerm_storage_account.storage_Account.id

  body = jsonencode({
  properties = {
  isSftpEnabled = true
  }
  })

  depends_on = [
  azurerm_storage_account.erpsftpserver
  ]
}

resource "azapi_resource" "sftplocaluseroncontainer" {
  count = var.enable_sftp ? 1 : 0
  type = "Microsoft.Storage/storageAccounts/localUsers@2021-09-01"
  parent_id = azurerm_storage_account.storage_Account.id
  name = "extpartner1"

  body = jsonencode({
  properties = {
  hasSshPassword = true,
  homeDirectory = "erproot/"
  hasSharedKey = true,
  hasSshKey = false,
  permissionScopes = [{
  permissions = "cwl",
  service = "blob",
  resourceName = "erproot"
  }]
  }
  })

  depends_on = [
  azurerm_storage_account.erpsftpserver,
  azapi_update_resource.enablesftp
  ]
}

resource "azapi_resource_action" "sftpcloudservicespassword" {
  count = var.enable_sftp ? 1 : 0

  type = "Microsoft.Storage/storageAccounts/localUsers@2022-05-01"
  resource_id = azapi_resource.sftplocaluseroncontainer.id
  action = "regeneratePassword"
  body = jsonencode({
  username = azapi_resource.sftplocaluseroncontainer[0].name
  })

  response_export_values = ["sshPassword"]
}