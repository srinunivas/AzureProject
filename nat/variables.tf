variable "nat_gateway_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku_name" {
  type = string
  default = "Standard"
}

variable "idle_timeout_in_minutes" {
  type = number
  default = 4
}

variable "zones" {
  type = set(string)
}

variable "nat_association_subnet_ids" {
  type = map(string)
}

variable "tags" {
  type = map(string)
}