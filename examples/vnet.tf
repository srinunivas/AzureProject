module "vnet" {
  source = "../vnet"

  vnet_name     = "Vnet-Dspmdemo-Lab-eastus"
  rg_name       = module.rg.resource_group_name
  location      = module.rg.location
  address_space = ["172.0.0.0/16"]
  tags          = local.tags
}