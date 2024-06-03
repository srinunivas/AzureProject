variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "key_vault" {
  type = object({
    name                        = optional(string, null)
    sku_name                    = string
    enabled_for_disk_encryption = bool
    purge_protection_enabled    = bool
  })
  default = {
    sku_name                    = "standard"
    enabled_for_disk_encryption = false
    purge_protection_enabled    = false
  }
}

variable "key_vault_key" {
  type = object({
    key_type = string
    key_size = number
    key_opts = list(string)
  })
  default = {
    key_opts = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
    key_size = 2048
    key_type = "RSA"
  }
}

variable "disk_encryption_set_enabled" {
  type    = bool
  default = false
}

variable "disk_encryption_set" {
  type = object({
    name                      = optional(string, null)
    encryption_type           = string
    auto_key_rotation_enabled = bool
    identity_type             = string
  })

  default = {
    auto_key_rotation_enabled = false
    encryption_type           = "EncryptionAtRestWithCustomerKey"
    identity_type             = "SystemAssigned"
  }
}

variable "disk_kv_access_policy_enabled" {
  type    = bool
  default = false
}

variable "disk_kv_access_policy_key_permissions" {
  type    = list(string)
  default = ["Create", "Delete", "Get", "Purge", "Recover", "Update", "List", "Decrypt", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "GetRotationPolicy"]
}

variable "user_kv_access_policy_enabled" {
  type    = bool
  default = false
}

variable "user_kv_access_policy_key_permissions" {
  type    = list(string)
  default = ["Create", "Delete", "Get", "Purge", "Recover", "Update", "List", "Decrypt", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "GetRotationPolicy"]
}

variable "role_assignment_enabled" {
  type    = bool
  default = false
}

variable "role_definition_name" {
  type    = string
  default = null
}