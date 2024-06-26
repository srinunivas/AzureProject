module "nat" {
  source = "../nat"

  nat_gateway_name           = "natgw-001"
  location                   = module.rg.location
  resource_group_name        = module.rg.resource_group_name
  sku_name                   = "Standard"
  idle_timeout_in_minutes    = 4
  zones                      = ["1"]
  nat_association_subnet_ids = { private_subnet_1 : module.private_subnet_1.id, private_subnet_2 : module.private_subnet_2.id }
  tags                       = local.tags
  org_name                   = "Safemarch"
  project_name               = "demo"
  env                        = "prod"
  region                     = "east-us"

  depends_on = [module.private_subnet_1, module.private_subnet_2, module.vnet]
}