module "lunix_vmss" {
  source = "../linux_vmss"

  vmss = {
    name                            = "vmsslinux-001"
    upgrade_policy_mode             = "Manual"
    admin_user                      = "ubn-azureuser"
    custom_data                     = <<-EOF
    <powershell>
    Add-WindowsFeature Web-Server
    Set-Content -Path "C:\\inetpub\\wwwroot\\index.html" -Value "<html><body><h1>Hello, World!</h1></body></html>"
    Start-Service W3SVC
    Write-Output 'This is some example data for file1.' | Out-File -FilePath C:\file1.txt
    Write-Output 'This is some example data for file2.' | Out-File -FilePath C:\file2.txt
    Invoke-WebRequest -Uri "https://dlptest.com/sample-data.pdf" -OutFile "C:\PII-sample-data.pdf"
    </powershell>
    EOF
    disable_password_authentication = true
    sku_name                        = "Standard_DS1_v2"
    instances                       = 1
  }

  source_image_reference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  data_disk = {
    lun                  = 0
    caching              = "ReadWrite"
    create_option        = "Empty"
    disk_size_gb         = 30
    storage_account_type = "Standard_LRS"
  }

  network_interface = {
    name    = "dspmdemoubnnetworkprofile"
    primary = true
  }

  ip_configuration = {
    name      = "ubnIPConfiguration"
    subnet_id = module.private_subnet_1.id
    primary   = true
  }
  resource_group_name = module.rg.resource_group_name
  location            = module.rg.location
  tags                = local.tags
  org_name            = "Safemarch"
  project_name        = "demo"
  env                 = "prod"
  region              = "east-us"
}