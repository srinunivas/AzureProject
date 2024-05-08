resource "azurerm_network_security_group" "vm_subnet_nsg" {
  name                = var.nsg_name            #"nsg-vm-subnet"
  location            = var.location            #azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name #azurerm_resource_group.rg.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "inbound_allow_rdp" {
  for_each                    = var.network_security_rules
  network_security_group_name = azurerm_network_security_group.vm_subnet_nsg.name
  resource_group_name         = var.resource_group_name
  name                        = each.key                              #"Inbound_Allow_Bastion_RDP"
  priority                    = each.value.priority                   #500
  direction                   = each.value.direction                  #"Inbound"
  access                      = each.value.access                     #"Allow"
  protocol                    = each.value.protocol                   #"Tcp"
  source_port_range           = each.value.source_port_range          #"*"
  destination_port_range      = each.value.destination_port_range     #"3389"
  source_address_prefix       = each.value.source_address_prefix      #azurerm_subnet.bastion_subnet.address_prefixes[0]
  destination_address_prefix  = each.value.destination_address_prefix #azurerm_subnet.vm_subnet.address_prefixes[0]
}

# resource "azurerm_network_security_rule" "inbound_allow_ssh" {
#   network_security_group_name = azurerm_network_security_group.vm_subnet_nsg.name
#   resource_group_name         = azurerm_resource_group.rg.name
#   name                        = "Inbound_Allow_Bastion_SSH"
#   priority                    = 510
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "22"
#   source_address_prefix       = azurerm_subnet.bastion_subnet.address_prefixes[0]
#   destination_address_prefix  = azurerm_subnet.vm_subnet.address_prefixes[0]
# }

# resource "azurerm_network_security_rule" "inbound_deny_all" {
#   network_security_group_name = azurerm_network_security_group.vm_subnet_nsg.name
#   resource_group_name         = azurerm_resource_group.rg.name
#   name                        = "Inbound_Deny_Any_Any"
#   priority                    = 1000
#   direction                   = "Inbound"
#   access                      = "Deny"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = "*"
#   destination_address_prefix  = azurerm_subnet.vm_subnet.address_prefixes[0]
# }

# resource "azurerm_network_security_rule" "outbound_allow_subnet" {
#   network_security_group_name = azurerm_network_security_group.vm_subnet_nsg.name
#   resource_group_name         = azurerm_resource_group.rg.name
#   name                        = "Outbound_Allow_Subnet_Any"
#   priority                    = 500
#   direction                   = "Outbound"
#   access                      = "Allow"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = azurerm_subnet.vm_subnet.address_prefixes[0]
#   destination_address_prefix  = azurerm_subnet.vm_subnet.address_prefixes[0]
# }

# resource "azurerm_network_security_rule" "outbound_deny_all" {
#   network_security_group_name = azurerm_network_security_group.vm_subnet_nsg.name
#   resource_group_name         = azurerm_resource_group.rg.name
#   name                        = "Outbound_Deny_Any_Any"
#   priority                    = 1000
#   direction                   = "Outbound"
#   access                      = "Deny"
#   protocol                    = "*"
#   source_port_range           = "*"
#   destination_port_range      = "*"
#   source_address_prefix       = azurerm_subnet.vm_subnet.address_prefixes[0]
#   destination_address_prefix  = "*"
# }

resource "azurerm_subnet_network_security_group_association" "nsg_vm_subnet_association" {
  network_security_group_id = azurerm_network_security_group.vm_subnet_nsg.id
  subnet_id                 = var.nsg_association_subnet_id #azurerm_subnet.vm_subnet.id
}