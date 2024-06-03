module "public_subnet_1" {
  source = "../subnets"

  subnet_name      = "com-pubsub-001"
  rg_name          = module.rg.resource_group_name
  vnet_name        = module.vnet.name
  address_prefixes = "172.0.1.0/24"

  org_name     = "Safemarch"
  project_name = "demo"
  env          = "prod"
  region       = "east-us"
}

module "public_subnet_2" {
  source = "../subnets"

  subnet_name      = "com-pubsub-002"
  rg_name          = module.rg.resource_group_name
  vnet_name        = module.vnet.name
  address_prefixes = "172.0.2.0/24"

  org_name     = "Safemarch"
  project_name = "demo"
  env          = "prod"
  region       = "east-us"
}

module "private_subnet_1" {
  source = "../subnets"

  subnet_name      = "com-prisub-001"
  rg_name          = module.rg.resource_group_name
  vnet_name        = module.vnet.name
  address_prefixes = "172.0.3.0/24"

  org_name     = "Safemarch"
  project_name = "demo"
  env          = "prod"
  region       = "east-us"
}

module "private_subnet_2" {
  source = "../subnets"

  subnet_name      = "com-prisub-002"
  rg_name          = module.rg.resource_group_name
  vnet_name        = module.vnet.name
  address_prefixes = "172.0.4.0/24"

  org_name     = "Safemarch"
  project_name = "demo"
  env          = "prod"
  region       = "east-us"
}

module "bastion_subnet" {
  source = "../subnets"

  subnet_name      = "AzureBastionSubnet"
  rg_name          = module.rg.resource_group_name
  vnet_name        = module.vnet.name
  address_prefixes = "172.0.5.0/24"

  org_name     = "Safemarch"
  project_name = "demo"
  env          = "prod"
  region       = "east-us"
}



