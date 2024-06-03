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

variable "vmss" {
  type = object({
    name                            = string
    upgrade_policy_mode             = string
    admin_user                      = string
    admin_password                  = string
    custom_data                     = string
    disable_password_authentication = bool
    sku_name                        = string
    instances                       = number
  })
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
  })
}

variable "data_disk" {
  type = object({
    lun                  = number
    caching              = string
    create_option        = string
    disk_size_gb         = number
    storage_account_type = string
  })
}

variable "network_interface" {
  type = object({
    name    = string
    primary = bool
  })
}

variable "ip_configuration" {
  type = object({
    name                                   = string
    subnet_id                              = string
    load_balancer_backend_address_pool_ids = optional(list(string), null)
    primary                                = bool
  })
}