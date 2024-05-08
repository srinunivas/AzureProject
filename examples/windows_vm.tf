# # #-----------------------------------------------------------
# # #      Public VM 1 - Windows
# # #-----------------------------------------------------------

# # module "public_windows_vm_1_nic" {
# #   source = "../nic"

# #   network_interface_name        = "public-windows-vm-1-nic"
# #   location                      = module.rg.location
# #   resource_group_name           = module.rg.resource_group_name
# #   ip_configuration_name         = "public-vm-1-nic-ip-config"
# #   subnet_id                     = module.public_subnet_1.id
# #   private_ip_address_allocation = "Dynamic"
# #   public_ip_address_id          = module.windows_vm_1_public_ip.public_ip
# #   tags                          = local.tags 
# # }

# # module "public_windows_vm_1" {
# #   source = "../windows_virtual_machine"

# #   vm_name               = "pub-win-vm-1"
# #   location              = module.rg.location
# #   resource_group_name   = module.rg.resource_group_name
# #   network_interface_ids = [module.public_windows_vm_1_nic.network_interface_id]
# #   size                  = "Standard_DS1_v2"

# #   os_disk = {
# #     name                 = "public-windows-vm-1-disk"
# #     caching              = "ReadWrite"
# #     storage_account_type = "Standard_LRS"
# #     #disk_size_gb         = 30
# #   }

# #   source_image_reference = {
# #     publisher = "MicrosoftWindowsServer"
# #     offer     = "WindowsServer"
# #     sku       = "2022-Datacenter"
# #     version   = "latest"
# #   }

# #   admin_username                  = "win-azureuser"
# #   admin_password                  = "win-azureuser@12345678"
# #   disable_password_authentication = true

# #   custom_data = <<-EOF
# #   <powershell>
# #   Add-WindowsFeature Web-Server
# #   Set-Content -Path "C:\\inetpub\\wwwroot\\index.html" -Value "<html><body><h1>Hello, World!</h1></body></html>"
# #   Start-Service W3SVC
# #   Write-Output 'This is some example data for file1.' | Out-File -FilePath C:\file1.txt
# #   Write-Output 'This is some example data for file2.' | Out-File -FilePath C:\file2.txt
# #   Invoke-WebRequest -Uri "https://dlptest.com/sample-data.pdf" -OutFile "C:\PII-sample-data.pdf"
# #   </powershell>
# #   EOF

  
# #   tags = local.tags
# # }

# # #-----------------------------------------------------------
# # #      Public VM 2 - Windows
# # #-----------------------------------------------------------

# # module "public_windows_vm_2_nic" {
# #   source = "../nic"

# #   network_interface_name        = "public-windows-vm-2-nic"
# #   location                      = module.rg.location
# #   resource_group_name           = module.rg.resource_group_name
# #   ip_configuration_name         = "public-vm-1-nic-ip-config"
# #   subnet_id                     = module.public_subnet_2.id
# #   private_ip_address_allocation = "Dynamic"
# #  # public_ip_address_id          = module.windows_vm_2_public_ip.public_ip
# #   tags                          = local.tags 
# # }

# # module "public_windows_vm_2" {
# #   source = "../windows_virtual_machine"

# #   vm_name               = "pub-win-vm-2"
# #   location              = module.rg.location
# #   resource_group_name   = module.rg.resource_group_name
# #   network_interface_ids = [module.public_windows_vm_2_nic.network_interface_id]
# #   size                  = "Standard_DS1_v2"

# #   os_disk = {
# #     name                 = "public-windows-vm-2-disk"
# #     caching              = "ReadWrite"
# #     storage_account_type = "Standard_LRS"
# #     disk_encryption_set_id = module.default_keyvault.disk_encryption_set_id
# #     #disk_size_gb         = 30
# #   }

# #   source_image_reference = {
# #     publisher = "MicrosoftWindowsServer"
# #     offer     = "WindowsServer"
# #     sku       = "2022-Datacenter"
# #     version   = "latest"
# #   }

# #   admin_username                  = "win-azureuser"
# #   admin_password                  = "win-azureuser@12345678"
# #   disable_password_authentication = true

# #   custom_data = <<-EOF
# #   <powershell>
# #   Add-WindowsFeature Web-Server
# #   Set-Content -Path "C:\\inetpub\\wwwroot\\index.html" -Value "<html><body><h1>Hello, World!</h1></body></html>"
# #   Start-Service W3SVC
# #   Write-Output 'This is some example data for file1.' | Out-File -FilePath C:\file1.txt
# #   Write-Output 'This is some example data for file2.' | Out-File -FilePath C:\file2.txt
# #   Invoke-WebRequest -Uri "https://dlptest.com/sample-data.pdf" -OutFile "C:\PII-sample-data.pdf"
# #   </powershell>
# #   EOF

  
# #   tags = local.tags
# # }

#-----------------------------------------------------------
#      Private VM 1 - Windows
#-----------------------------------------------------------

module "private_windows_vm_1_nic" {
  source = "../nic"

  network_interface_name        = "private-windows-vm-1-nic"
  location                      = module.rg.location
  resource_group_name           = module.rg.resource_group_name
  ip_configuration_name         = "private-vm-1-nic-ip-config"
  subnet_id                     = module.private_subnet_1.id
  private_ip_address_allocation = "Dynamic"
  tags                          = local.tags 
}

module "private_windows_vm_1" {
  source = "../windows_virtual_machine"

  vm_name               = "pri-win-vm-1"
  location              = module.rg.location
  resource_group_name   = module.rg.resource_group_name
  network_interface_ids = [module.private_windows_vm_1_nic.network_interface_id]
  size                  = "Standard_DS1_v2"

  os_disk = {
    name                 = "private-windows-vm-1-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    #disk_size_gb         = 30
  }

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  admin_username                  = "win-azureuser"
  admin_password                  = "win-azureuser@12345678"
  disable_password_authentication = true

  custom_data = <<-EOF
  <powershell>
  Add-WindowsFeature Web-Server
  Set-Content -Path "C:\\inetpub\\wwwroot\\index.html" -Value "<html><body><h1>Hello, World!</h1></body></html>"
  Start-Service W3SVC
  Write-Output 'This is some example data for file1.' | Out-File -FilePath C:\file1.txt
  Write-Output 'This is some example data for file2.' | Out-File -FilePath C:\file2.txt
  Invoke-WebRequest -Uri "https://dlptest.com/sample-data.pdf" -OutFile "C:\PII-sample-data.pdf"
  </powershell>
  EOF

  
  tags = local.tags
}

#-----------------------------------------------------------
#      Private VM 2 - Windows
#-----------------------------------------------------------

module "private_windows_vm_2_nic" {
  source = "../nic"

  network_interface_name        = "private-windows-vm-2-nic"
  location                      = module.rg.location
  resource_group_name           = module.rg.resource_group_name
  ip_configuration_name         = "private-vm-1-nic-ip-config"
  subnet_id                     = module.private_subnet_2.id
  private_ip_address_allocation = "Dynamic"
  tags                          = local.tags 
}

module "private_windows_vm_2" {
  source = "../windows_virtual_machine"

  vm_name               = "pri-win-vm-2"
  location              = module.rg.location
  resource_group_name   = module.rg.resource_group_name
  network_interface_ids = [module.private_windows_vm_2_nic.network_interface_id]
  size                  = "Standard_DS1_v2"

  os_disk = {
    name                 = "private-windows-vm-2-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    #disk_encryption_set_id = module.default_keyvault.disk_encryption_set_id
  }

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  admin_username                  = "win-azureuser"
  admin_password                  = "win-azureuser@12345678"
  disable_password_authentication = true

  custom_data = <<-EOF
  <powershell>
  Add-WindowsFeature Web-Server
  Set-Content -Path "C:\\inetpub\\wwwroot\\index.html" -Value "<html><body><h1>Hello, World!</h1></body></html>"
  Start-Service W3SVC
  Write-Output 'This is some example data for file1.' | Out-File -FilePath C:\file1.txt
  Write-Output 'This is some example data for file2.' | Out-File -FilePath C:\file2.txt
  Invoke-WebRequest -Uri "https://dlptest.com/sample-data.pdf" -OutFile "C:\PII-sample-data.pdf"
  </powershell>
  EOF

  
  tags = local.tags
}
