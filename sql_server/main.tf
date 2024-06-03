data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "example" {
  name                = var.mssql_server.user_assigned_identity_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_mssql_server" "example" {
  name                         = "${var.org_name}-${var.project_name}-${var.env}-${var.region}-${var.mssql_server.name}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.mssql_server.version
  administrator_login          = var.mssql_server.administrator_login
  administrator_login_password = var.mssql_server.administrator_login_password
  minimum_tls_version          = var.mssql_server.minimum_tls_version

  azuread_administrator {
    login_username = azurerm_user_assigned_identity.example.name
    object_id      = azurerm_user_assigned_identity.example.principal_id
  }

  identity {
    type         = var.mssql_server.identity_type
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }

  public_network_access_enabled = var.mssql_server.public_network_access_enabled

  primary_user_assigned_identity_id            = azurerm_user_assigned_identity.example.id
  transparent_data_encryption_key_vault_key_id = try(azurerm_key_vault_key.example[0].id, null)
  tags                                         = var.tags
}

resource "azurerm_mssql_virtual_network_rule" "example" {
  name      = var.mssql_server.network_rule_name
  server_id = azurerm_mssql_server.example.id
  subnet_id = var.mssql_server.subnet_id
}

resource "azurerm_mssql_database" "example" {
  name         = var.mssql_server.database_name
  server_id    = azurerm_mssql_server.example.id
  collation    = var.mssql_server.collation
  license_type = var.mssql_server.license_type
  max_size_gb  = var.mssql_server.max_size_gb
  sku_name     = var.mssql_server.sku_name
  tags         = var.tags
}

resource "azurerm_key_vault" "example" {
  count                       = var.keyvault ? 1 : 0
  name                        = var.keyvalut.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = var.keyvalut.enabled_for_disk_encryption
  tenant_id                   = azurerm_user_assigned_identity.example.tenant_id
  soft_delete_retention_days  = var.keyvalut.soft_delete_retention_days
  purge_protection_enabled    = var.keyvalut.purge_protection_enabled

  sku_name = var.keyvalut.sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = var.keyvalut.object_id_key_permissions
    secret_permissions = var.keyvalut.object_id_secret_permissions
  }

  access_policy {
    tenant_id = azurerm_user_assigned_identity.example.tenant_id
    object_id = azurerm_user_assigned_identity.example.principal_id

    key_permissions    = var.keyvalut.principal_id_key_permissions
    secret_permissions = var.keyvalut.principal_id_secret_permissions
  }
}

resource "azurerm_key_vault_key" "example" {
  count      = var.keyvault ? 1 : 0
  depends_on = [azurerm_key_vault.example]

  name         = var.keyvalut.keyname
  key_vault_id = azurerm_key_vault.example[0].id
  key_type     = var.keyvalut.key_type
  key_size     = var.keyvalut.key_size

  key_opts = var.keyvalut.key_opts #
}