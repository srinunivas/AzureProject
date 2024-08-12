module "cmk_keyvault" {
  source = "../key_vault"

  location            = module.rg.location
  resource_group_name = module.rg.resource_group_name
  key_vault = {
    name                        = "dspmdemokv"
    sku_name                    = "premium"
    enabled_for_disk_encryption = true
    purge_protection_enabled    = true
  }
  disk_encryption_set = {
    name                      = "dspmdemo-diskencset-001"
    encryption_type           = "EncryptionAtRestWithCustomerKey"
    auto_key_rotation_enabled = false
    identity_type             = "SystemAssigned"
  }
  disk_encryption_set_enabled   = true
  disk_kv_access_policy_enabled = true
  user_kv_access_policy_enabled = true
  role_assignment_enabled       = true
  role_definition_name          = "Key Vault Crypto Service Encryption User"
}