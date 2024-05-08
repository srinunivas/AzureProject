variable "tags" {
  description = "Tag(s) to apply to resources being created"
  type        = map(string)
  default     = {}
}

variable "public_ip_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "allocation_method" {
  type = string
}