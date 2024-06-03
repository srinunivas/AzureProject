#------------------------------------------------------------------------------------
#           SQL Server - Private - CMK encryption
#-------------------------------------------------------------------------------------

module "private_sql" {
  source = "../sql_server"

  location            = module.sa_rg.location
  resource_group_name = module.sa_rg.resource_group_name
  tags                = local.tags
  org_name            = "safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"

  keyvault = true

  mssql_server = {
    name                          = "pri-sql-001"
    user_assigned_identity_name   = "private-dspmdemo-user"
    version                       = "12.0"
    administrator_login           = "dspmdemo-admin"
    administrator_login_password  = "example@User!"
    minimum_tls_version           = "1.2"
    identity_type                 = "UserAssigned"
    public_network_access_enabled = true
    network_rule_name             = "pri-dspmdemo-sql-vnet-rule"
    subnet_id                     = module.sql_public_subnet_1.id
    database_name                 = "pri-dspmdemo-db"
    collation                     = "SQL_Latin1_General_CP1_CI_AS"
    license_type                  = "LicenseIncluded"
    read_scale                    = true
    sku_name                      = "S0"
    zone_redundant                = true
    enclave_type                  = "VBS"
  }

  keyvalut = {
    name                            = "dspmdemosqlkv"
    enabled_for_disk_encryption     = true
    soft_delete_retention_days      = 7
    purge_protection_enabled        = true
    sku_name                        = "standard"
    object_id_key_permissions       = ["Get", "List", "Create", "Delete", "Update", "Recover", "Purge", "GetRotationPolicy"]
    object_id_secret_permissions    = ["Get", "List"]
    principal_id_key_permissions    = ["Get", "WrapKey", "UnwrapKey"]
    principal_id_secret_permissions = ["Get", "List"]
    keyname                         = "dspmdemosqlkey"
    key_type                        = "RSA"
    key_size                        = 2048
    key_opts                        = ["unwrapKey", "wrapKey"]
  }

  depends_on = [module.sql_public_subnet_1]
}

