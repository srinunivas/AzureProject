module "public_ip" {
  source = "../public_ip"

  public_ip_name      = "bastion-PIP-dspmdemo"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
}

module "linux_vm_1_public_ip" {
  source = "../public_ip"

  public_ip_name      = "PIP-linux-vm-1-ip-dspmdemo"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
}

module "linux_vm_2_public_ip" {
  source = "../public_ip"

  public_ip_name      = "PIP-linux-vm-2-ip-dspmdemo"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
}

module "windows_vm_1_public_ip" {
  source = "../public_ip"

  public_ip_name      = "PIP-windows-vm-1-ip-dspmdemo"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
}

module "windows_vm_2_public_ip" {
  source = "../public_ip"

  public_ip_name      = "PIP-windows-vm-2-ip-dspmdemo"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
}


module "nlb_pip" {
  source = "../public_ip"

  public_ip_name      = "nib-pip-dspmdemo"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
}

module "aglb_pip" {
  source = "../public_ip"

  public_ip_name      = "aglb-pip-dspmdemo"
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  allocation_method   = "Static"
  tags                = local.tags
}