resource "azurerm_lb" "my_lb" {
  name                = var.load_balancer.name
  location            = var.location #azurerm_resource_group.my_resource_group.location
  resource_group_name = var.resource_group_name #azurerm_resource_group.my_resource_group.name
  sku                 = var.load_balancer.sku #"Standard"

  frontend_ip_configuration {
    name                 = var.load_balancer.public_ip_name
    public_ip_address_id = var.load_balancer.public_ip_address_id #azurerm_public_ip.my_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "my_lb_pool" {
  loadbalancer_id      = azurerm_lb.my_lb.id
  name                 = var.load_balancer.lb_backend_address_pool_name #"test-pool"
}

resource "azurerm_lb_probe" "my_lb_probe" {
  loadbalancer_id     = azurerm_lb.my_lb.id
  name                = var.load_balancer.lb_probe_name #"test-probe"
  port                = var.load_balancer.port #80
}

resource "azurerm_lb_rule" "my_lb_rule" {
  loadbalancer_id                = azurerm_lb.my_lb.id
  name                           = var.load_balancer.lb_rule_name #"test-rule"
  protocol                       = var.load_balancer.protocol #"Tcp"
  frontend_port                  = var.load_balancer.port
  backend_port                   = var.load_balancer.port
  disable_outbound_snat          = var.load_balancer.disable_outbound_snat #true
  frontend_ip_configuration_name = var.load_balancer.public_ip_name
  probe_id                       = azurerm_lb_probe.my_lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.my_lb_pool.id]
}

resource "azurerm_lb_outbound_rule" "my_lboutbound_rule" {
  #resource_group_name     = var.resource_group_name #azurerm_resource_group.my_resource_group.name
  name                    = var.load_balancer.outbound_rule_name #"test-outbound"
  loadbalancer_id         = azurerm_lb.my_lb.id
  protocol                = var.load_balancer.protocol #"Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.my_lb_pool.id

  frontend_ip_configuration {
    name = var.load_balancer.public_ip_name
  }
}

# resource "azurerm_lb_backend_address_pool_address" "example-2" {
#   name                                = var.load_balancer.lb_backend_address_pool_address_name #"address2"
#   backend_address_pool_id             = azurerm_lb_backend_address_pool.my_lb_pool.id
#   backend_address_ip_configuration_id = var.load_balancer.backend_address_ip_configuration_id #azurerm_lb.backend-lb-R2.frontend_ip_configuration[0].id
# }

resource "azurerm_network_interface_backend_address_pool_association" "example" {
  for_each = var.load_balancer.backend_address_pool_association
  network_interface_id    = each.value.network_interface_id #azurerm_network_interface.example.id
  ip_configuration_name   = each.value.ip_configuration_name #"testconfiguration1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.my_lb_pool.id
}