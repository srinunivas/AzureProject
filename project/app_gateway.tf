module "application_gateway" {
  source = "../application_gateway"

  app_gateway = {
    name                           = "apgwlb"
    sku_name                       = "Standard_v2"
    tier                           = "Standard_v2"
    capacity                       = 2
    gateway_ip_config_name         = "gateway-ip-configuration"
    subnet_id                      = "/subscriptions/86c82398-3448-43c6-9f4b-954558c30c5a/resourceGroups/sundarsd-rg/providers/Microsoft.Network/virtualNetworks/sundarsd-vnet/subnets/default"
    frontend_port_name             = "FrontendPort"
    port                           = 80
    frontend_ip_configuration_name = "AGIPConfig"
    public_ip_address_id           = module.aglb_pip.public_ip
    backend_address_pool_name      = "agBackendPool"
    http_listener_name             = "aglistener"
    http_setting_name              = "agHTTPsetting"
    cookie_based_affinity          = "Disabled"
    protocol                       = "Http"
    request_timeout                = 60
    listener_name                  = "ag_listener"
    request_routing_rule_name      = "ag_rule_name"
    backend_address_pool_association = {
      pool1 = {
        ip_configuration_name = module.private_windows_vm_1_nic.ip_configuration_name
        network_interface_id  = module.private_windows_vm_1_nic.network_interface_id
      },
      pool2 = {
        ip_configuration_name = module.private_windows_vm_2_nic.ip_configuration_name
        network_interface_id  = module.private_windows_vm_2_nic.network_interface_id
      }
    }

  }

  resource_group_name = "sundarsd-rg"
  location            = "East US"
  tags                = local.tags
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"

  depends_on = [module.private_windows_vm_1, module.private_windows_vm_2]
}