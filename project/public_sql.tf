module "sql_vnet" {
  source = "../vnet"

  vnet_name     = "vnetsql-001"
  rg_name       = module.sa_rg.resource_group_name
  location      = module.sa_rg.location
  address_space = ["173.0.0.0/16"]
  tags          = local.tags
  org_name      = "safemarch"
  project_name  = "demo"
  env           = "prod"
  region        = "east-us"
}

module "sql_public_subnet_1" {
  source = "../subnets"

  subnet_name       = "sql-pubsub-001"
  rg_name           = module.sa_rg.resource_group_name
  vnet_name         = module.sql_vnet.name
  address_prefixes  = "173.0.1.0/24"
  service_endpoints = ["Microsoft.Sql"]
  org_name          = "safemarch"
  project_name      = "demo"
  env               = "prod"
  region            = "east-us"
}

module "sql_private_subnet_1" {
  source = "../subnets"

  subnet_name       = "sql-prisub-001"
  rg_name           = module.sa_rg.resource_group_name
  vnet_name         = module.sql_vnet.name
  address_prefixes  = "173.0.3.0/24"
  service_endpoints = ["Microsoft.Sql"]
  org_name          = "safemarch"
  project_name      = "demo"
  env               = "prod"
  region            = "east-us"
}

module "sql_bastion_subnet" {
  source = "../subnets"

  subnet_name      = "AzureBastionSubnet"
  rg_name          = module.sa_rg.resource_group_name
  vnet_name        = module.sql_vnet.name
  address_prefixes = "173.0.5.0/24"
  org_name         = "safemarch"
  project_name     = "demo"
  env              = "prod"
  region           = "east-us"
}

module "sql_nat" {
  source = "../nat"

  nat_gateway_name           = "sqlnatgw"
  location                   = module.sa_rg.location
  resource_group_name        = module.sa_rg.resource_group_name
  sku_name                   = "Standard"
  idle_timeout_in_minutes    = 4
  zones                      = ["1"]
  nat_association_subnet_ids = { sql_private_subnet_1 : module.sql_private_subnet_1.id }
  tags                       = local.tags
  org_name                   = "safemarch"
  project_name               = "demo"
  env                        = "prod"
  region                     = "east-us"

  depends_on = [module.sql_private_subnet_1, module.sql_vnet]
}

#------------------------------------------------------------------------------------
#           SQL Server - Public - Default encryption
#-------------------------------------------------------------------------------------

module "public_sql" {
  source = "../sql_server"

  location            = module.sa_rg.location
  resource_group_name = module.sa_rg.resource_group_name
  tags                = local.tags
  org_name            = "safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"

  mssql_server = {
    name                          = "pub-sql-001"
    user_assigned_identity_name   = "dspmdemo-user"
    version                       = "12.0"
    administrator_login           = "dspmdemo-admin"
    administrator_login_password  = "example@User!"
    minimum_tls_version           = "1.2"
    identity_type                 = "UserAssigned"
    public_network_access_enabled = true
    network_rule_name             = "dspmdemo-sql-vnet-rule"
    subnet_id                     = module.sql_public_subnet_1.id
    database_name                 = "dspmdemo-db"
    collation                     = "SQL_Latin1_General_CP1_CI_AS"
    license_type                  = "LicenseIncluded"
    read_scale                    = true
    sku_name                      = "S0"
    zone_redundant                = true
    enclave_type                  = "VBS"
  }

  depends_on = [module.sql_public_subnet_1]
}

