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

variable "rg_name" {
  description = "The resource group the vnet should be placed"
  type        = string
}

variable "vnet_name" {
  description = "Name of Virtual Network that Subnet belongs where resources will reside"
  type        = string
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  type        = string
}

variable "address_space" {
  description = "Address space for the vnet being created"
  type        = list(string)
}

variable "dns_servers" {
  description = "DNS servers"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tag(s) to apply to resources being created"
  type        = map(string)
  default     = {}
}
