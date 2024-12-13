resource "azurerm_windows_virtual_machine" "vm-win-01" {
  name                  = "${var.org_name}-${var.project_name}-${var.env}-${var.region}-${var.vm_name}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  computer_name         = var.vm_name
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = var.network_interface_ids
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
  tags = var.tags
}


resource "azurerm_virtual_machine_extension" "example" {
  name                 = "CustomScriptExtension"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm-win-01.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
  {
    "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"& {Get-Content '${path.module}/webserver.ps1' | Out-String | Invoke-Expression}\""
  }
  SETTINGS
}


