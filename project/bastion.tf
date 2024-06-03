module "bastion" {
  source = "../Bastin-host"

  bastion_host_name   = "bastionhost"
  location            = module.rg.location
  resource_group_name = module.rg.resource_group_name

  ip_configuration_name = "bastionhost-pubsub-001-ip-config"
  subnet_id             = module.bastion_subnet.id
  public_ip_address_id  = module.public_ip.public_ip

  org_name     = "Safemarch"
  project_name = "demo"
  env          = "prod"
  region       = "east-us"
}