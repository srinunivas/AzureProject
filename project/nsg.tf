module "nsg1" {
  source = "../nsg"

  resource_group_name       = module.rg.resource_group_name
  nsg_name                  = "nsg-pub1-001"
  location                  = module.rg.location
  tags                      = local.tags
  org_name                  = "Safemarch"
  project_name              = "demo"
  env                       = "prod"
  region                    = "east-us"
  nsg_association_subnet_id = module.public_subnet_1.id

  network_security_rules = {
    Inbound_Allow_Bastion_SSH = {
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    Inbound_Allow_Bastion_RDP = {
      priority                   = 102
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    Inbound_Allow_Bastion_http = {
      priority                   = 103
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    Inbound_Allow_http = {
      priority                   = 104
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    Outbound_Allow_Subnet_Any = {
      priority                   = 101
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    Inbound_Deny_Any_Any = {
      priority                   = 102
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
  }
}

#-----------------------------------------------------------------------------
#                       NSG - Public Subnet 2
#-----------------------------------------------------------------------------
module "nsg2" {
  source = "../nsg"

  resource_group_name       = module.rg.resource_group_name
  nsg_name                  = "nsg-pub2-001"
  location                  = module.rg.location
  tags                      = local.tags
  org_name                  = "Safemarch"
  project_name              = "demo"
  env                       = "prod"
  region                    = "east-us"
  nsg_association_subnet_id = module.public_subnet_2.id

  network_security_rules = {

    Inbound_Allow_http = {
      priority                   = 103
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    Outbound_Allow_Subnet_Any = {
      priority                   = 101
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}