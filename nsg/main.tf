resource "azurerm_network_security_group" "vm_subnet_nsg" {
  name                = "${var.org_name}-${var.project_name}-${var.env}-${var.region}-${var.nsg_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "inbound_allow_rdp" {
  for_each                    = var.network_security_rules
  network_security_group_name = azurerm_network_security_group.vm_subnet_nsg.name
  resource_group_name         = var.resource_group_name
  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
}

resource "azurerm_subnet_network_security_group_association" "nsg_vm_subnet_association" {
  network_security_group_id = azurerm_network_security_group.vm_subnet_nsg.id
  subnet_id                 = var.nsg_association_subnet_id
}