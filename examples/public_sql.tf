module "sql_vnet" {
  source = "../vnet"

  vnet_name     = "Vnet-sql-Dspmdemo-Lab-eastus"
  rg_name       = module.sa_rg.resource_group_name
  location      = module.sa_rg.location
  address_space = ["173.0.0.0/16"]
  tags          = local.tags
}

module "sql_public_subnet_1" {
  source = "../subnets"

  subnet_name      = "public-sql-subnet-1-dspmdemo-lab-eastus"
  rg_name          = module.sa_rg.resource_group_name
  vnet_name        = module.sql_vnet.name
  address_prefixes = "173.0.1.0/24"
  service_endpoints    = ["Microsoft.Sql"]
}

module "sql_private_subnet_1" {
  source = "../subnets"

  subnet_name      = "private-sql-subnet-1-dspmdemo-lab-eastus"
  rg_name          = module.sa_rg.resource_group_name
  vnet_name        = module.sql_vnet.name
  address_prefixes = "173.0.3.0/24"
  service_endpoints    = ["Microsoft.Sql"]
}

module "sql_bastion_subnet" {
  source = "../subnets"

  subnet_name      = "AzureBastionSubnet"
  rg_name          = module.sa_rg.resource_group_name
  vnet_name        = module.sql_vnet.name
  address_prefixes = "173.0.5.0/24"
}

module "nat" {
    source = "../nat"

    nat_gateway_name = "dspmdemo-NAT"
    location = module.sa_rg.location
    resource_group_name = module.sa_rg.resource_group_name
    sku_name = "Standard"
    idle_timeout_in_minutes = 4
    zones = ["1"]
    nat_association_subnet_ids = {sql_private_subnet_1: module.sql_private_subnet_1.id}
    tags = local.tags

    depends_on = [ module.sql_private_subnet_1, module.sql_vnet ]
}

#------------------------------------------------------------------------------------
#           SQL Server - Public - Default encryption
#-------------------------------------------------------------------------------------

module "public_sql" {
  source = "../sql_server"

  location = module.sa_rg.location
  resource_group_name = module.sa_rg.resource_group_name
  tags = local.tags

  mssql_server = {
    name = "pub-sql-dspmdemo-lab-eastus"
    user_assigned_identity_name = "dspmdemo-user"
    version = "12.0"
    administrator_login = "dspmdemo-admin"
    administrator_login_password = "example@User!"
    minimum_tls_version = "1.2"
    identity_type = "UserAssigned"
    public_network_access_enabled = true
    #transparent_data_encryption_key_vault_key_id = optional(string, null)
    network_rule_name= "dspmdemo-sql-vnet-rule"
    subnet_id = module.sql_public_subnet_1.id
    database_name = "dspmdemo-db"
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

