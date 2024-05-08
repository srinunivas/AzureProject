resource "azurerm_windows_virtual_machine_scale_set" "example" {
  name                = var.vmss.name 
  location            = var.location
  resource_group_name = var.resource_group_name
  instances           = var.vmss.instances 
  sku                 = var.vmss.sku_name
  admin_username      = var.vmss.admin_user
  admin_password       = var.vmss.admin_password 
  computer_name_prefix = "vm-"

  source_image_reference  {
    publisher = var.source_image_reference.publisher 
    offer     = var.source_image_reference.offer 
    sku       = var.source_image_reference.sku 
    version   = var.source_image_reference.version 
  }

  os_disk {
    caching           = var.os_disk.caching 
    storage_account_type  = var.os_disk.storage_account_type 
  }

  data_disk {
    lun           = var.data_disk.lun 
    caching       = var.data_disk.caching 
    create_option = var.data_disk.create_option
    disk_size_gb  = var.data_disk.disk_size_gb
    storage_account_type  = var.data_disk.storage_account_type
  }

  custom_data          =  base64encode(var.vmss.custom_data)
  network_interface  {
    name    = var.network_interface.name  
    primary = var.network_interface.primary 

    ip_configuration {
      name                                   = var.ip_configuration.name 
      subnet_id                              = var.ip_configuration.subnet_id 
      load_balancer_backend_address_pool_ids = var.ip_configuration.load_balancer_backend_address_pool_ids
      primary                                = var.ip_configuration.primary 
    }
  }
}