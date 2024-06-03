module "public_ip" {
  source = "../public_ip"

  public_ip_name      = "pip-bastion-001"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"
}

module "linux_vm_1_public_ip" {
  source = "../public_ip"

  public_ip_name      = "pip-linux-001"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"
}

module "linux_vm_2_public_ip" {
  source = "../public_ip"

  public_ip_name      = "pip-linux-002"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"
}

module "windows_vm_1_public_ip" {
  source = "../public_ip"

  public_ip_name      = "pip-windows-001"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"
}

module "windows_vm_2_public_ip" {
  source = "../public_ip"

  public_ip_name      = "pip-windows-002"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"
}


module "nlb_pip" {
  source = "../public_ip"

  public_ip_name      = "pip-nlb-001"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"
}

module "aglb_pip" {
  source = "../public_ip"

  public_ip_name      = "pip-apgwlb-001"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"
}