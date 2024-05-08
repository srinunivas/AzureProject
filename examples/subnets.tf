module "public_subnet_1" {
  source = "../subnets"

  subnet_name      = "public-subnet-1-dspmdemo-lab-eastus"
  rg_name          = module.rg.resource_group_name
  vnet_name        = module.vnet.name
  address_prefixes = "172.0.1.0/24"
}

module "public_subnet_2" {
  source = "../subnets"

  subnet_name      = "public-subnet-2-dspmdemo-lab-eastus"
  rg_name          = module.rg.resource_group_name
  vnet_name        = module.vnet.name
  address_prefixes = "172.0.2.0/24"
}

module "private_subnet_1" {
  source = "../subnets"

  subnet_name      = "private-subnet-1-dspmdemo-lab-eastus"
  rg_name          = module.rg.resource_group_name
  vnet_name        = module.vnet.name
  address_prefixes = "172.0.3.0/24"
}

module "private_subnet_2" {
  source = "../subnets"

  subnet_name      = "private-subnet-2-dspmdemo-lab-eastus"
  rg_name          = module.rg.resource_group_name
  vnet_name        = module.vnet.name
  address_prefixes = "172.0.4.0/24"
}

module "bastion_subnet" {
  source = "../subnets"

  subnet_name      = "AzureBastionSubnet"
  rg_name          = module.rg.resource_group_name
  vnet_name        = module.vnet.name
  address_prefixes = "172.0.5.0/24"
}



