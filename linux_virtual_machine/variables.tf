variable "vm_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "network_interface_ids" {
  type = list(string)
}

variable "size" {
  type = string
}

variable "os_disk" {
  type = object({
    name                   = optional(string, "")
    caching                = optional(string, "")
    storage_account_type   = optional(string, "")
    disk_encryption_set_id = optional(string, null)
    disk_size_gb           = optional(number, null)
  })
  default = {}
}

variable "source_image_reference" {
  type = object({
    publisher = optional(string, "")
    offer     = optional(string, "")
    sku       = optional(string, "")
    version   = optional(string, "")
  })
  default = {}
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
  default = null
}

variable "admin_ssh_key_username" {
  type = string
  default = null
}

variable "disable_password_authentication" {
  type = bool
}

variable "custom_data" {
  type    = string
  default = null
}

variable "tags" {
  type = map(string)
}
