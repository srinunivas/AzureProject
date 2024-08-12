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

  resource_group_name = "rgcompute-001"
  location            = "East US"
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"
}

module "sa_rg" {
  source = "../resource_group"

  resource_group_name = "rgsql-001"
  location            = "East US"
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"
}