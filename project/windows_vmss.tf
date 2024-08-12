module "windows_vmss" {
  source = "../windows_vmss"

  vmss = {
    name                            = "vmsswin-001"
    upgrade_policy_mode             = "Manual"
    admin_user                      = "win-azureuser"
    admin_password                  = "win-azureuser@12345678"
    custom_data                     = <<-EOF
        #!/bin/bash
        sudo apt-get update
        sudo apt-get install apache2 -y
        sudo service apache2 start
        echo "<!DOCTYPE html>
        <html>
        <head>
        <title>Hello, World!</title>
        </head>
        <body>
        <h1>Hello, World!</h1>
        <p>This is a simple 'Hello, World!' webpage served by Apache2 on an AWS EC2 instance.</p>
        </body>
        </html>" | sudo tee /var/www/html/index.html
        echo "This is some example data for file1." > /home/ubuntu/file1.txt
        echo "This is some example data for file2." > /home/ubuntu/file2.txt
        mkfs.ext4 /dev/xvdf
        mkdir /mnt/ebs
        mount /dev/xvdf /mnt/ebs
        echo "This is some example data for file1." > /mnt/ebs/Sample.txt 
        wget -O /mnt/ebs/PII-sample-data.pdf "https://dlptest.com/sample-data.pdf"
        EOF
    disable_password_authentication = true
    sku_name                        = "Standard_F2"
    instances                       = 1
  }

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core"
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
    disk_size_gb         = 127
    storage_account_type = "Standard_LRS"
  }

  network_interface = {
    name    = "dspmdemowinnetworkprofile"
    primary = true
  }

  ip_configuration = {
    name      = "winIPConfiguration"
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