resource "azurerm_subnet" "sub" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.address_prefixes]
  #private_endpoint_network_policies_enabled     = !var.enable_private_endpoint
  #private_link_service_network_policies_enabled = !var.enable_private_link_service
  service_endpoints = var.service_endpoints == [] ? null : var.service_endpoints

  dynamic "delegation" {
    for_each = length(var.subnet_delegation) > 0 ? var.subnet_delegation : []
    content {
      name = delegation.value["name"]

      service_delegation {
        name    = delegation.value["service_delegation_name"]
        actions = delegation.value["service_delegation_actions"]
      }
    }
  }
}