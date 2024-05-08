variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "keyvault" {
  type = bool
  default = false
}

variable "mssql_server" {
  type = object({
    name = string
    user_assigned_identity_name = string
    version = string
    administrator_login = string
    administrator_login_password = string
    minimum_tls_version = string
    identity_type = string
    public_network_access_enabled = optional(bool, false)
    transparent_data_encryption_key_vault_key_id = optional(string, null)
    network_rule_name= string
    subnet_id = string
    database_name = string
    collation = string
    license_type = string
    max_size_gb = optional(number, null)
    read_scale = optional(bool, true)
    sku_name = optional(string, null)
    zone_redundant = optional(bool, true)
    enclave_type = optional(string, null)
  })
}