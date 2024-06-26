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

variable "network_interface_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "ip_configuration_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "private_ip_address_allocation" {
  type = string
}

variable "public_ip_address_id" {
  type    = string
  default = null
}
variable "associate_nsg" {
  type    = bool
  default = false
}
variable "network_security_group_id" {
  type    = string
  default = null
}

variable "tags" {
  type = map(string)
}