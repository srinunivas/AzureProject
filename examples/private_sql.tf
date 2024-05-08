module "sql_keyvault" {
    source = "../key_vault"

    location = module.sa_rg.location
    resource_group_name = module.sa_rg.resource_group_name
    key_vault = {
      name = "Dspmdemo-sql-kv"
      sku_name = "premium"
      enabled_for_disk_encryption = true
      purge_protection_enabled = true
    }
    disk_encryption_set_enabled = false
    disk_kv_access_policy_enabled = false
    user_kv_access_policy_enabled = true
    role_assignment_enabled       = false
    role_definition_name = "Key Vault Crypto Service Encryption User"
}


#------------------------------------------------------------------------------------
#           SQL Server - Private - CMK encryption
#-------------------------------------------------------------------------------------

module "private_sql" {
  source = "../sql_server"

  location = module.sa_rg.location
  resource_group_name = module.sa_rg.resource_group_name
  tags = local.tags

  keyvault = true

  mssql_server = {
    name = "pri-sql-dspmdemo-lab-eastus"
    user_assigned_identity_name = "private-dspmdemo-user"
    version = "12.0"
    administrator_login = "dspmdemo-admin"
    administrator_login_password = "example@User!"
    minimum_tls_version = "1.2"
    identity_type = "UserAssigned"
    public_network_access_enabled = true
    transparent_data_encryption_key_vault_key_id = module.sql_keyvault.key_vault_key_id
    network_rule_name= "pri-dspmdemo-sql-vnet-rule"
    subnet_id = module.sql_public_subnet_1.id
    database_name = "pri-dspmdemo-db"
    collation = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    #max_size_gb = 4
    read_scale = true
    sku_name = "S0"
    zone_redundant = true
    enclave_type = "VBS"
  }

  depends_on = [ module.sql_public_subnet_1 ]
}

