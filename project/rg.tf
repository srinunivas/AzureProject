provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}
module "rg" {
  source = "../resource_group"

  resource_group_name = "RG-dspmdemo-prod-eastus-01"
  location            = "East US"
}

module "sa_rg" {
  source = "../resource_group"

  resource_group_name = "RG-dspmdemo-storage-eastus-02"
  location            = "East US"
}