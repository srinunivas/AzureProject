resource "azurerm_windows_virtual_machine" "vm-win-01" {
  name                  = var.vm_name             
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
  tags        = var.tags
}


resource "null_resource" "example" {

  count = var.ip_address != null ? 1 : 0

  triggers = {
    instance_id = azurerm_windows_virtual_machine.vm-win-01.id
  }

  provisioner "local-exec" {
    command = "echo Remote execution completed"
  }

  provisioner "remote-exec" {
    inline = [
      "winrm quickconfig -quiet",
      "winrm set winrm/config/winrs @{MaxMemoryPerShellMB=\"1024\"}",
      "winrm set winrm/config @{MaxTimeoutms=\"1800000\"}",
      "winrm set winrm/config/service @{AllowUnencrypted=\"true\"}",
      "winrm set winrm/config/service/auth @{Basic=\"true\"}",
      "powershell.exe Add-WindowsFeature Web-Server",
      "powershell.exe -Command \"Set-Content -Path 'C:\\\\inetpub\\\\wwwroot\\\\index.html' -Value '<html><body><h1>Hello, World!</h1></body></html>'\"",
      "powershell.exe Start-Service W3SVC",
      "powershell.exe Write-Output 'This is some example data for file1.' | Out-File -FilePath 'C:\\file1.txt'",
      "powershell.exe Write-Output 'This is some example data for file2.' | Out-File -FilePath 'C:\\file2.txt'",
      "powershell.exe Invoke-WebRequest -Uri 'https://dlptest.com/sample-data.pdf' -OutFile 'C:\\PII-sample-data.pdf'"
    ]
  }

  connection {
      type     = "winrm"
      user     = var.admin_username
      password = var.admin_password
      host     = var.ip_address
      port     = 5985
      insecure = true
      https    = false
    }

  depends_on = [azurerm_windows_virtual_machine.vm-win-01]
}

