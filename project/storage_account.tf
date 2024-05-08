#----------------------------------------------------------
# Public - Storage Account 1 - GRS
#----------------------------------------------------------
module "public_grs_sa_1" {
  source = "../storage_account"

  resource_group_name = module.sa_rg.resource_group_name
  location            = module.sa_rg.location

  storageaccount = {
    name = "dspmdemosapublicgrspmk1"
    account_tier = "Standard"
    account_replication_type = "GRS"
    enable_https_traffic_only = true
    is_hns_enabled = true
    nfsv3_enabled = false
    infrastructure_encryption_enabled = false
    public_network_access_enabled = true
    account_kind = "StorageV2"
    access_tier = "Hot"
    index_document = "index.html"
    identity_type = "UserAssigned"
    identity_ids   = [module.private_sql.user_assigned_identity_id]
  } 
  storagecontioner = {
    container1 = {
        name                   = "appcontainer"
        container_access_type  = "blob"
    },
    container2 = {
        name                   = "dbcontainer"
        container_access_type  = "private"
    }
  }
    customer_managed_key = {
    enabled      = false
  }
  
  storage_blob = {
    blob1 = {
    storage_container_name = "appcontainer"
    name                   = "PCI.pdf"
    type                   = "Block"
    source                 = "./files/PCI/PCI.pdf"
    },
    blob11 = {
    storage_container_name = "dbcontainer"
    name                   = "PCI.pdf"
    type                   = "Block"
    source                 = "./files/PCI/PCI.pdf"
    },
    blob2 = {
    storage_container_name = "appcontainer"
    name                   = "PII.csv"
    type                   = "Block"
    source                 = "./files/PII/PII.csv"
    },
    blob22 = {
    storage_container_name = "dbcontainer"
    name                   = "PII.csv"
    type                   = "Block"
    source                 = "./files/PII/PII.csv"
    },
    blob3 = {
    storage_container_name = "appcontainer"
    name                   = "patients.csv"
    type                   = "Block"
    source                 = "./files/patients/patients.csv"
    },
    blob33 = {
    storage_container_name = "dbcontainer"
    name                   = "patients.csv"
    type                   = "Block"
    source                 = "./files/patients/patients.csv"
    },
    blob4 = {
    storage_container_name = "appcontainer"
    name                   = "index.html"
    type                   = "Block"
    source                 = "./files/static-web-page/index.html"
    }
    blob44 = {
    storage_container_name = "dbcontainer"
    name                   = "index.html"
    type                   = "Block"
    source                 = "./files/static-web-page/index.html"
    }
    }

  tags = local.tags
}

#----------------------------------------------------------
# Public - Storage Account 2 - GRS
#----------------------------------------------------------
module "public_grs_sa_2" {
  source = "../storage_account"

  resource_group_name = module.sa_rg.resource_group_name
  location            = module.sa_rg.location

  storageaccount = {
    name = "dspmdemosapublicgrscmk2"
    account_tier = "Standard"
    account_replication_type = "GRS"
    enable_https_traffic_only = true
    is_hns_enabled = true
    nfsv3_enabled = false
    infrastructure_encryption_enabled = false
    public_network_access_enabled = true
    account_kind = "StorageV2"
    access_tier = "Hot"
    index_document = "index.html"
    identity_type = "UserAssigned"
    identity_ids   = [module.private_sql.user_assigned_identity_id]
  } 

  customer_managed_key = {
    enabled      = true
    key_vault_id = module.private_sql.key_vault_id
    key_name     = module.private_sql.key_vault_key_name
    user_assigned_identity_id = module.private_sql.user_assigned_identity_id
  }

  storagecontioner = {
    container1 = {
        name                   = "appcontainer"
        container_access_type  = "blob"
    },
    container2 = {
        name                   = "dbcontainer"
        container_access_type  = "private"
    }
  }
  
  storage_blob = {
    blob1 = {
    storage_container_name = "appcontainer"
    name                   = "PCI.pdf"
    type                   = "Block"
    source                 = "./files/PCI/PCI.pdf"
    },
    blob11 = {
    storage_container_name = "dbcontainer"
    name                   = "PCI.pdf"
    type                   = "Block"
    source                 = "./files/PCI/PCI.pdf"
    },
    blob2 = {
    storage_container_name = "appcontainer"
    name                   = "PII.csv"
    type                   = "Block"
    source                 = "./files/PII/PII.csv"
    },
    blob22 = {
    storage_container_name = "dbcontainer"
    name                   = "PII.csv"
    type                   = "Block"
    source                 = "./files/PII/PII.csv"
    },
    blob3 = {
    storage_container_name = "appcontainer"
    name                   = "patients.csv"
    type                   = "Block"
    source                 = "./files/patients/patients.csv"
    },
    blob33 = {
    storage_container_name = "dbcontainer"
    name                   = "patients.csv"
    type                   = "Block"
    source                 = "./files/patients/patients.csv"
    },
    blob4 = {
    storage_container_name = "appcontainer"
    name                   = "index.html"
    type                   = "Block"
    source                 = "./files/static-web-page/index.html"
    }
    blob44 = {
    storage_container_name = "dbcontainer"
    name                   = "index.html"
    type                   = "Block"
    source                 = "./files/static-web-page/index.html"
    }
    }

  tags = local.tags
}


#----------------------------------------------------------
# Private - Storage Account 1 - LRS
#----------------------------------------------------------
module "private_lrs_sa_1" {
  source = "../storage_account"

  resource_group_name = module.sa_rg.resource_group_name
  location            = module.sa_rg.location

  storageaccount = {
    name = "dspmdemosaprivatelrscmk1"
    account_tier = "Standard"
    account_replication_type = "LRS"
    enable_https_traffic_only = true
    is_hns_enabled = true
    nfsv3_enabled = false
    infrastructure_encryption_enabled = false
    public_network_access_enabled = true
    account_kind = "BlockBlobStorage"
    access_tier = "Hot"
    index_document = "index.html"
    network_rules_default_action = "Allow"
    identity_type = "UserAssigned"
    identity_ids   = [module.private_sql.user_assigned_identity_id]
  } 

  customer_managed_key = {
    enabled      = true
    key_vault_id = module.private_sql.key_vault_id
    key_name     = module.private_sql.key_vault_key_name
    user_assigned_identity_id = module.private_sql.user_assigned_identity_id
  }

  storagecontioner = {
    container1 = {
        name                   = "appcontainer"
        container_access_type  = "private"
    }
    container2 = {
        name                   = "dbcontainer"
        container_access_type  = "private"
    }
  }

  storage_blob = {
    blob1 = {
    storage_container_name = "appcontainer"
    name                   = "PCI.pdf"
    type                   = "Block"
    source                 = "./files/PCI/PCI.pdf"
    },
    blob11 = {
    storage_container_name = "dbcontainer"
    name                   = "PCI.pdf"
    type                   = "Block"
    source                 = "./files/PCI/PCI.pdf"
    },
    blob2 = {
    storage_container_name = "appcontainer"
    name                   = "PII.csv"
    type                   = "Block"
    source                 = "./files/PII/PII.csv"
    },
    blob22 = {
    storage_container_name = "dbcontainer"
    name                   = "PII.csv"
    type                   = "Block"
    source                 = "./files/PII/PII.csv"
    },
    blob3 = {
    storage_container_name = "appcontainer"
    name                   = "patients.csv"
    type                   = "Block"
    source                 = "./files/patients/patients.csv"
    },
    blob33 = {
    storage_container_name = "dbcontainer"
    name                   = "patients.csv"
    type                   = "Block"
    source                 = "./files/patients/patients.csv"
    },
    blob4 = {
    storage_container_name = "appcontainer"
    name                   = "index.html"
    type                   = "Block"
    source                 = "./files/static-web-page/index.html"
    }
    blob44 = {
    storage_container_name = "dbcontainer"
    name                   = "index.html"
    type                   = "Block"
    source                 = "./files/static-web-page/index.html"
    }
    }
  
  tags = local.tags
}

#----------------------------------------------------------
# Private - Storage Account 2 - LRS
#----------------------------------------------------------
module "public_lrs_sa_2" {
  source = "../storage_account"

  resource_group_name = module.sa_rg.resource_group_name
  location            = module.sa_rg.location

  storageaccount = {
    name = "dspmdemosaprivatelrscmk2"
    account_tier = "Standard"
    account_replication_type = "LRS"
    enable_https_traffic_only = true
    is_hns_enabled = true
    nfsv3_enabled = false
    infrastructure_encryption_enabled = false
    public_network_access_enabled = true
    account_kind = "BlockBlobStorage"
    access_tier = "Hot"
    index_document = "index.html"
    network_rules_default_action = "Allow"
    identity_type = "UserAssigned"
    identity_ids   = [module.private_sql.user_assigned_identity_id]
  } 
  
  customer_managed_key = {
    enabled      = true
    key_vault_id = module.private_sql.key_vault_id
    key_name     = module.private_sql.key_vault_key_name
    user_assigned_identity_id = module.private_sql.user_assigned_identity_id
  }

  storagecontioner = {
    container1 = {
        name                   = "appcontainer"
        container_access_type  = "private"
    }
    container2 = {
        name                   = "dbcontainer"
        container_access_type  = "private"
    }
  }

  storage_blob = {
    blob1 = {
    storage_container_name = "appcontainer"
    name                   = "PCI.pdf"
    type                   = "Block"
    source                 = "./files/PCI/PCI.pdf"
    },
    blob11 = {
    storage_container_name = "dbcontainer"
    name                   = "PCI.pdf"
    type                   = "Block"
    source                 = "./files/PCI/PCI.pdf"
    },
    blob2 = {
    storage_container_name = "appcontainer"
    name                   = "PII.csv"
    type                   = "Block"
    source                 = "./files/PII/PII.csv"
    },
    blob22 = {
    storage_container_name = "dbcontainer"
    name                   = "PII.csv"
    type                   = "Block"
    source                 = "./files/PII/PII.csv"
    },
    blob3 = {
    storage_container_name = "appcontainer"
    name                   = "patients.csv"
    type                   = "Block"
    source                 = "./files/patients/patients.csv"
    },
    blob33 = {
    storage_container_name = "dbcontainer"
    name                   = "patients.csv"
    type                   = "Block"
    source                 = "./files/patients/patients.csv"
    },
    blob4 = {
    storage_container_name = "appcontainer"
    name                   = "index.html"
    type                   = "Block"
    source                 = "./files/static-web-page/index.html"
    }
    blob44 = {
    storage_container_name = "dbcontainer"
    name                   = "index.html"
    type                   = "Block"
    source                 = "./files/static-web-page/index.html"
    }
    }
  
  tags = local.tags
}
