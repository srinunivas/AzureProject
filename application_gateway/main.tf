resource "azurerm_application_gateway" "main" {
  name                = "${var.org_name}-${var.project_name}-${var.env}-${var.region}-${var.app_gateway.name}"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.app_gateway.sku_name
    tier     = var.app_gateway.tier
    capacity = var.app_gateway.capacity
  }

  gateway_ip_configuration {
    name      = var.app_gateway.gateway_ip_config_name
    subnet_id = var.app_gateway.subnet_id
  }

  frontend_port {
    name = var.app_gateway.frontend_port_name
    port = var.app_gateway.port
  }

  frontend_ip_configuration {
    name                 = var.app_gateway.frontend_ip_configuration_name
    public_ip_address_id = var.app_gateway.public_ip_address_id
  }

  backend_address_pool {
    name = var.app_gateway.backend_address_pool_name
  }

  backend_http_settings {
    name                  = var.app_gateway.http_setting_name
    cookie_based_affinity = var.app_gateway.cookie_based_affinity
    port                  = var.app_gateway.port
    protocol              = var.app_gateway.protocol
    request_timeout       = var.app_gateway.request_timeout
  }

  http_listener {
    name                           = var.app_gateway.listener_name
    frontend_ip_configuration_name = var.app_gateway.frontend_ip_configuration_name
    frontend_port_name             = var.app_gateway.frontend_port_name
    protocol                       = var.app_gateway.protocol
  }

  request_routing_rule {
    name                       = var.app_gateway.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = var.app_gateway.listener_name
    backend_address_pool_name  = var.app_gateway.backend_address_pool_name
    backend_http_settings_name = var.app_gateway.http_setting_name
    priority                   = 1
  }

  tags = var.tags
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "nic-assoc" {
  for_each                = var.app_gateway.backend_address_pool_association
  network_interface_id    = each.value.network_interface_id
  ip_configuration_name   = each.value.ip_configuration_name
  backend_address_pool_id = one(azurerm_application_gateway.main.backend_address_pool).id
}