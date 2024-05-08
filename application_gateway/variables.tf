variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "app_gateway" {
  type = object({
    name = string
    sku_name = string
    tier = string
    capacity = number
    gateway_ip_config_name = string
    subnet_id = string
    frontend_port_name = string
    port = optional(number, 80)
    frontend_ip_configuration_name = string
    public_ip_address_id = string
    backend_address_pool_name = string
    http_listener_name = string
    http_setting_name  = string
    cookie_based_affinity = optional(string, "Disabled")
    protocol = optional(string, "Http")
    request_timeout = optional(number, 60)
    listener_name = string
    request_routing_rule_name = string
    backend_address_pool_association = map(object({
      network_interface_id = string
      ip_configuration_name = string
    }))
  })
}