variable "rg_name" {
  description = "Resource group in which to deploy the resource"
  type        = string
}

variable "subnet_name" {
  description = "Name of the route table that will be created with this module"
  type        = string
}

variable "vnet_name" {
  description = "Name of Virtual Network that Subnet belongs where resources will reside"
  type        = string
}

variable "address_prefixes" {
  description = "List of subnets to be created within a vnet"
  type        = string
}

variable "enable_private_endpoint" {
  description = "Boolean parameter to Enable or Disable private endpoint on the subnet"
  type        = bool
  default     = false
}

variable "enable_private_link_service" {
  description = "Boolean parameter to Enable or Disable private link service on the subnet"
  type        = bool
  default     = false
}

variable "service_endpoints" {
  description = "Boolean parameter to Enable or Disable network policies for the private link endpoint on the subnet"
  type        = list(any)
  default     = []
}

variable "subnet_delegation" {
  description = "Subnet Delegation"
  type = list(object({
    name                       = string
    service_delegation_name    = string
    service_delegation_actions = list(string)
  }))
  default = []
}
