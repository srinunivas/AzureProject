# Create an SSH key
resource "tls_private_key" "ubn_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "vm_ubn_01" {
  name                  = var.vm_name               #"vm-ubn-01"
  location              = var.location              #azurerm_resource_group.rg.location
  resource_group_name   = var.resource_group_name   #azurerm_resource_group.rg.name
  network_interface_ids = var.network_interface_ids #[azurerm_network_interface.nic_ubn_01.id]
  size                  = var.size                  #"Standard_DS1_v2"

  os_disk {
    name                   = var.os_disk.name                 #"disk-os-win-01"
    caching                = var.os_disk.caching              #"ReadWrite"
    storage_account_type   = var.os_disk.storage_account_type #"Standard_LRS"
    disk_encryption_set_id = var.os_disk.disk_encryption_set_id
    disk_size_gb           = var.os_disk.disk_size_gb
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher #"Canonical"
    offer     = var.source_image_reference.offer     #"UbuntuServer"
    sku       = var.source_image_reference.sku       #"18.04-LTS"
    version   = var.source_image_reference.version   #"latest"
  }

  computer_name                   = var.vm_name                         #"vm-ubn-01"
  admin_username                  = var.admin_username                  #"ubn-azureuser"
  disable_password_authentication = var.disable_password_authentication #true

  admin_ssh_key {
    username   = var.admin_ssh_key_username                 #"ubn-azureuser"
    public_key = tls_private_key.ubn_ssh.public_key_openssh #tls_private_key.ubn_ssh.public_key_openssh
  }

  custom_data = base64encode(var.custom_data) #base64encode(local.custom_data)
  tags        = var.tags
}