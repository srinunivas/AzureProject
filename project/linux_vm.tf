#-----------------------------------------------------------
#      Public VM 1 - linux
#-----------------------------------------------------------

module "public_linux_vm_1_nic" {
  source = "../nic"

  network_interface_name        = "public-linux-vm-1-nic"
  location                      = module.rg.location
  resource_group_name           = module.rg.resource_group_name
  ip_configuration_name         = "public-vm-1-nic-ip-config"
  subnet_id                     = module.public_subnet_1.id
  private_ip_address_allocation = "Dynamic"
  network_security_group_id     = module.nsg1.id
  associate_nsg                 = true 
  public_ip_address_id          = module.linux_vm_1_public_ip.public_ip
  tags                          = local.tags
}

module "public_linux_vm_1" {
  source = "../linux_virtual_machine"

  vm_name               = "public-linux-vm-1"
  location              = module.rg.location
  resource_group_name   = module.rg.resource_group_name
  network_interface_ids = [module.public_linux_vm_1_nic.network_interface_id]
  size                  = "Standard_DS1_v2"

  os_disk = {
    name                 = "public-linux-vm-1-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  
  admin_username                  = "ubn-azureuser"
  disable_password_authentication = false
  admin_password                  = "ubn-azureuser@12345678"

  custom_data = <<-EOF
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

  tags = local.tags
}

#-----------------------------------------------------------
#      Public VM 2 - linux - cmk
#-----------------------------------------------------------

module "public_linux_vm_2_nic" {
  source = "../nic"

  network_interface_name        = "public-linux-vm-2-nic"
  location                      = module.rg.location
  resource_group_name           = module.rg.resource_group_name
  ip_configuration_name         = "public-vm-2-nic-ip-config"
  subnet_id                     = module.public_subnet_2.id
  private_ip_address_allocation = "Dynamic"
  public_ip_address_id          = module.linux_vm_2_public_ip.public_ip
  tags                          = local.tags
}

module "public_linux_vm_2" {
  source = "../linux_virtual_machine"

  vm_name               = "public-linux-vm-2"
  location              = module.rg.location
  resource_group_name   = module.rg.resource_group_name
  network_interface_ids = [module.public_linux_vm_2_nic.network_interface_id]
  size                  = "Standard_DS1_v2"

  os_disk = {
    name                 = "public-linux-vm-2-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_encryption_set_id = module.cmk_keyvault.disk_encryption_set_id
    disk_size_gb         = 30
  }

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  admin_username                  = "ubn-azureuser"
  disable_password_authentication = false
  admin_password                  = "ubn-azureuser@12345678"

  custom_data = <<-EOF
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

  tags = local.tags
}

#-----------------------------------------------------------
#      Private VM 1 - linux
#-----------------------------------------------------------

module "private_linux_vm_1_nic" {
  source = "../nic"

  network_interface_name        = "private-linux-vm-1-nic"
  location                      = module.rg.location
  resource_group_name           = module.rg.resource_group_name
  ip_configuration_name         = "private-vm-1-nic-ip-config"
  subnet_id                     = module.private_subnet_1.id
  private_ip_address_allocation = "Dynamic"
  tags                          = local.tags
}

module "private_linux_vm_1" {
  source = "../linux_virtual_machine"

  vm_name               = "private-linux-vm-1"
  location              = module.rg.location
  resource_group_name   = module.rg.resource_group_name
  network_interface_ids = [module.private_linux_vm_1_nic.network_interface_id]
  size                  = "Standard_DS1_v2"

  os_disk = {
    name                 = "private-linux-vm-1-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  admin_username                  = "ubn-azureuser"
  disable_password_authentication = false
  admin_password                  = "ubn-azureuser@12345678"

  custom_data = <<-EOF
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

  tags = local.tags
}

#-----------------------------------------------------------
#      Private VM 2 - linux - cmk
#-----------------------------------------------------------

module "private_linux_vm_2_nic" {
  source = "../nic"

  network_interface_name        = "public-linux-vm-2-nic"
  location                      = module.rg.location
  resource_group_name           = module.rg.resource_group_name
  ip_configuration_name         = "private-vm-2-nic-ip-config"
  subnet_id                     = module.private_subnet_2.id
  private_ip_address_allocation = "Dynamic"
  tags                          = local.tags
}

module "private_linux_vm_2" {
  source = "../linux_virtual_machine"

  vm_name               = "private-linux-vm-2"
  location              = module.rg.location
  resource_group_name   = module.rg.resource_group_name
  network_interface_ids = [module.private_linux_vm_2_nic.network_interface_id]
  size                  = "Standard_DS1_v2"

  os_disk = {
    name                 = "private-linux-vm-2-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_encryption_set_id = module.cmk_keyvault.disk_encryption_set_id
    disk_size_gb         = 30
  }

  source_image_reference = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  admin_username                  = "ubn-azureuser"
  disable_password_authentication = false
  admin_password                  = "ubn-azureuser@12345678"

  custom_data = <<-EOF
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

  tags = local.tags
}