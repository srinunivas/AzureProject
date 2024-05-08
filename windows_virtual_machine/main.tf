resource "azurerm_windows_virtual_machine" "vm-win-01" {
  name                  = var.vm_name             #"vm-win-01"
  resource_group_name   = var.resource_group_name #azurerm_resource_group.rg.name
  location              = var.location #azurerm_resource_group.rg.location
  size                  = var.size                #"Standard_DS2_v2"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = var.network_interface_ids #[azurerm_network_interface.nic_win_01.id]

  os_disk {
    name                   = var.os_disk.name                 #"disk-os-win-01"
    caching                = var.os_disk.caching              #"ReadWrite"
    storage_account_type   = var.os_disk.storage_account_type #"Standard_LRS"
    disk_encryption_set_id = var.os_disk.disk_encryption_set_id
    disk_size_gb           = var.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher #"MicrosoftWindowsServer"
    offer     = var.source_image_reference.offer     #"WindowsServer"
    sku       = var.source_image_reference.sku       #"2022-Datacenter"
    version   = var.source_image_reference.version   #"latest"
  }

  custom_data = base64encode(var.custom_data) #base64encode(local.custom_data)
  tags        = var.tags
}

