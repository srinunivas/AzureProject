data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "example" {
  name                = var.mssql_server.user_assigned_identity_name #"example-admin"
  location            = var.location #azurerm_resource_group.example.location
  resource_group_name = var.resource_group_name #azurerm_resource_group.example.name
}

resource "azurerm_mssql_server" "example" {
  name                         = var.mssql_server.name #"example-resource"
  resource_group_name          = var.resource_group_name #azurerm_resource_group.example.name
  location                     = var.location #azurerm_resource_group.example.location
  version                      = var.mssql_server.version #"12.0"
  administrator_login          = var.mssql_server.administrator_login #"Example-Administrator"
  administrator_login_password = var.mssql_server.administrator_login_password #"Example_Password!"
  minimum_tls_version          = var.mssql_server.minimum_tls_version #"1.2"

  azuread_administrator {
    login_username = azurerm_user_assigned_identity.example.name
    object_id      = azurerm_user_assigned_identity.example.principal_id
  }

  identity {
    type         = var.mssql_server.identity_type #"UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.example.id]
  }

  public_network_access_enabled                = var.mssql_server.public_network_access_enabled

  primary_user_assigned_identity_id            = azurerm_user_assigned_identity.example.id
  transparent_data_encryption_key_vault_key_id = try(azurerm_key_vault_key.example[0].id, null) #var.mssql_server.transparent_data_encryption_key_vault_key_id #azurerm_key_vault_key.example.id
  tags = var.tags
}

resource "azurerm_mssql_virtual_network_rule" "example" {
  name      = var.mssql_server.network_rule_name #"sql-vnet-rule"
  server_id = azurerm_mssql_server.example.id
  subnet_id = var.mssql_server.subnet_id #azurerm_subnet.example.id
}

resource "azurerm_mssql_database" "example" {
  name           = var.mssql_server.database_name #"example-db"
  server_id      = azurerm_mssql_server.example.id
  collation      = var.mssql_server.collation #"SQL_Latin1_General_CP1_CI_AS"
  license_type   = var.mssql_server.license_type #"LicenseIncluded"
  max_size_gb    = var.mssql_server.max_size_gb #4
  #read_scale     = var.mssql_server.read_scale #true
  sku_name       = var.mssql_server.sku_name #"S0"
  #zone_redundant = var.mssql_server.zone_redundant #true
  #enclave_type   = var.mssql_server.enclave_type #"VBS"

  tags = var.tags

  # prevent the possibility of accidental data loss
#   lifecycle {
#     prevent_destroy = true
#   }
}

#Create a key vault with access policies which allow for the current user to get, list, create, delete, update, recover, purge and getRotationPolicy for the key vault key and also add a key vault access policy for the Microsoft Sql Server instance User Managed Identity to get, wrap, and unwrap key(s)
resource "azurerm_key_vault" "example" {
  count = var.keyvault ? 1 : 0 
  name                        = "sqldspmdemokv"
  location                    = var.location #azurerm_resource_group.example.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = azurerm_user_assigned_identity.example.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = ["Get", "List", "Create", "Delete", "Update", "Recover", "Purge", "GetRotationPolicy"]
  }

  access_policy {
    tenant_id = azurerm_user_assigned_identity.example.tenant_id
    object_id = azurerm_user_assigned_identity.example.principal_id

    key_permissions = ["Get", "WrapKey", "UnwrapKey"]
  }
}

resource "azurerm_key_vault_key" "example" {
  count = var.keyvault ? 1 : 0 
  depends_on = [azurerm_key_vault.example]

  name         = "sqldspmdemokvkey"
  key_vault_id = azurerm_key_vault.example[0].id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = ["unwrapKey", "wrapKey"]
}