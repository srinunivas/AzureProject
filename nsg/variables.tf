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

variable "resource_group_name" {
  type = string
}

variable "nsg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "nsg_association_subnet_id" {
  type = string
}

variable "network_security_rules" {
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {}
}