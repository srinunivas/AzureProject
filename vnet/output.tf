output "name" {
  description = "Name of the vnet that is created"
  value       = azurerm_virtual_network.vnet.name
}

output "id" {
  description = "Id of the vnet that is created"
  value       = azurerm_virtual_network.vnet.id
}

output "guid" {
  description = "The GUID of the virtual network"
  value       = azurerm_virtual_network.vnet.guid
}

output "vnet_info" {
  description = "vNet object information"
  value = {
    address_space       = azurerm_virtual_network.vnet.address_space
    resource_group_name = azurerm_virtual_network.vnet.resource_group_name
    dns_servers         = azurerm_virtual_network.vnet.dns_servers
    location            = azurerm_virtual_network.vnet.location
  }
}

output "vnet_object" {
  description = "vNet object"
  value       = azurerm_virtual_network.vnet
}