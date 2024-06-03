resource "azurerm_lb" "my_lb" {
  name                = "${var.org_name}-${var.project_name}-${var.env}-${var.region}-${var.load_balancer.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.load_balancer.sku

  frontend_ip_configuration {
    name                 = var.load_balancer.public_ip_name
    public_ip_address_id = var.load_balancer.public_ip_address_id
  }
}

resource "azurerm_lb_backend_address_pool" "my_lb_pool" {
  loadbalancer_id = azurerm_lb.my_lb.id
  name            = var.load_balancer.lb_backend_address_pool_name
}

resource "azurerm_lb_probe" "my_lb_probe" {
  loadbalancer_id = azurerm_lb.my_lb.id
  name            = var.load_balancer.lb_probe_name
  port            = var.load_balancer.port
}

resource "azurerm_lb_rule" "my_lb_rule" {
  loadbalancer_id                = azurerm_lb.my_lb.id
  name                           = var.load_balancer.lb_rule_name
  protocol                       = var.load_balancer.protocol
  frontend_port                  = var.load_balancer.port
  backend_port                   = var.load_balancer.port
  disable_outbound_snat          = var.load_balancer.disable_outbound_snat
  frontend_ip_configuration_name = var.load_balancer.public_ip_name
  probe_id                       = azurerm_lb_probe.my_lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.my_lb_pool.id]
}

resource "azurerm_lb_outbound_rule" "my_lboutbound_rule" {
  name                    = var.load_balancer.outbound_rule_name
  loadbalancer_id         = azurerm_lb.my_lb.id
  protocol                = var.load_balancer.protocol
  backend_address_pool_id = azurerm_lb_backend_address_pool.my_lb_pool.id

  frontend_ip_configuration {
    name = var.load_balancer.public_ip_name
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "example" {
  for_each                = var.load_balancer.backend_address_pool_association
  network_interface_id    = each.value.network_interface_id
  ip_configuration_name   = each.value.ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.my_lb_pool.id
}