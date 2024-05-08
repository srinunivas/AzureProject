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
    network_rule_name= "pri-dspmdemo-sql-vnet-rule"
    subnet_id = module.sql_public_subnet_1.id
    database_name = "pri-dspmdemo-db"
    collation = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    read_scale = true
    sku_name = "S0"
    zone_redundant = true
    enclave_type = "VBS"
  }

  depends_on = [ module.sql_public_subnet_1 ]
}

