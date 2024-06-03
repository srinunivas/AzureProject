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
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  type = string
}