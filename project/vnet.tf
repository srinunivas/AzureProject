module "vnet" {
  source = "../vnet"

  vnet_name     = "vnetcompute-001"
  rg_name       = module.rg.resource_group_name
  location      = module.rg.location
  address_space = ["172.0.0.0/16"]
  tags          = local.tags
  org_name      = "Safemarch"
  project_name  = "demo"
  env           = "prod"
  region        = "east-us"
}