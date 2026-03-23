resource "azurerm_public_ip" "main" {
  for_each = var.vm_config

  name                = "${var.prefix}-pip-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  for_each = var.vm_config

  name                = "${var.prefix}-nic-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.private_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main[each.key].id
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  for_each = var.vm_config

  network_interface_id      = azurerm_network_interface.main[each.key].id
  network_security_group_id = var.network_security_group_id
}

resource "azurerm_linux_virtual_machine" "main" {
  for_each = var.vm_config

  name                  = "${var.prefix}-vm-${each.key}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = each.value.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.main[each.key].id]

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }

  os_disk {
    name                 = "${var.prefix}-osdisk-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = each.value.os_disk_type
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }
}