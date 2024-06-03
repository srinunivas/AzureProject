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

variable "storageaccount" {
  type = object({
    name                              = string
    account_tier                      = string
    account_replication_type          = string
    enable_https_traffic_only         = optional(bool, false)
    is_hns_enabled                    = optional(bool, false)
    nfsv3_enabled                     = optional(bool, false)
    infrastructure_encryption_enabled = optional(bool, false)
    public_network_access_enabled     = optional(bool, false)
    account_kind                      = string
    access_tier                       = string
    index_document                    = optional(string, null)
    network_rules_default_action      = optional(string, "Allow")
    identity_type                     = optional(string, "SystemAssigned")
    identity_ids                      = optional(list(string), null)
  })
}

variable "customer_managed_key" {
  type = object({
    enabled                   = optional(bool, false)
    key_vault_id              = optional(string, null)
    key_name                  = optional(string, null)
    user_assigned_identity_id = optional(string, null)
  })
  default = {}
}

variable "storagecontioner" {
  type = map(object({
    name                  = string
    container_access_type = string
  }))
}

variable "storage_blob" {
  type = map(object({
    storage_container_name = optional(string, null)
    name                   = optional(string, null)
    type                   = optional(string, null)
    source                 = optional(string, null)
  }))
  default = {}
}
