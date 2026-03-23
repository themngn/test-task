resource "azurerm_resource_group" "softserve-rg" {
  name     = "${var.prefix}-resources"
  location = "Poland Central"
}

module "network" {
  source = "./modules/network"

  prefix              = var.prefix
  location            = azurerm_resource_group.softserve-rg.location
  resource_group_name = azurerm_resource_group.softserve-rg.name
  security_rules      = var.security_rules
}

resource "tls_private_key" "vm-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "vm-key-private" {
  content         = tls_private_key.vm-key.private_key_openssh
  filename        = "${path.module}/vm-key.pem"
  file_permission = "0600"
}


module "virtual_machine" {
  source = "./modules/virtual_machine"

  prefix                    = var.prefix
  resource_group_name       = azurerm_resource_group.softserve-rg.name
  location                  = azurerm_resource_group.softserve-rg.location
  private_subnet_id         = module.network.private_subnet_id
  public_subnet_id          = module.network.public_subnet_id
  network_security_group_id = module.network.network_security_group_id
  vm_config                 = var.vm_config
  admin_username            = var.admin_username
  admin_password            = var.admin_password
  ssh_public_key            = tls_private_key.vm-key.public_key_openssh
}
