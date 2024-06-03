variable "org_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "load_balancer" {
  type = object({
    name                         = string
    sku                          = string
    public_ip_name               = string
    public_ip_address_id         = string
    lb_backend_address_pool_name = string
    lb_probe_name                = string
    port                         = number
    protocol                     = string
    lb_rule_name                 = string
    disable_outbound_snat        = bool
    outbound_rule_name           = string
    backend_address_pool_association = map(object({
      network_interface_id  = string
      ip_configuration_name = string
    }))
  })
}