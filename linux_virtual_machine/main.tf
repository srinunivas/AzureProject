resource "azurerm_linux_virtual_machine" "vm_ubn_01" {
  name                  = var.vm_name               
  location              = var.location              
  resource_group_name   = var.resource_group_name   
  network_interface_ids = var.network_interface_ids 
  size                  = var.size                  

  os_disk {
    name                   = var.os_disk.name                 
    caching                = var.os_disk.caching             
    storage_account_type   = var.os_disk.storage_account_type 
    disk_encryption_set_id = var.os_disk.disk_encryption_set_id
    disk_size_gb           = var.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher 
    offer     = var.source_image_reference.offer     
    sku       = var.source_image_reference.sku       
    version   = var.source_image_reference.version   
  }

  computer_name                   = var.vm_name                         
  admin_username                  = var.admin_username  
  admin_password                  = var.admin_password                
  disable_password_authentication = var.disable_password_authentication 

  user_data = base64encode(var.custom_data) 
  tags        = var.tags
}