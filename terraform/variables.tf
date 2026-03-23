variable "subscription_id" {
  type        = string
  description = "The Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "The Service Principal App ID"
}

variable "client_secret" {
  type        = string
  description = "The Service Principal Password"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "The Azure Tenant ID"
}

variable "prefix" {
  type        = string
  description = "The prefix for the resources"
  default     = "softserve-1"
}

variable "vm_config" {
  type = map(object({
    name         = string
    vm_size      = string
    publisher    = string
    offer        = string
    sku          = string
    version      = string
    os_disk_type = string
  }))
  description = "A map of virtual machine configurations"
  default = {
    "vm1" = {
      name         = "vm1"
      vm_size      = "Standard_B2als_v2"
      publisher    = "Canonical"
      offer        = "ubuntu-24_04-lts"
      sku          = "server"
      version      = "latest"
      os_disk_type = "Standard_LRS"
    },
    "vm2" = {
      name         = "vm2"
      vm_size      = "Standard_B2als_v2"
      publisher    = "Canonical"
      offer        = "ubuntu-24_04-lts"
      sku          = "server"
      version      = "latest"
      os_disk_type = "Standard_LRS"
    }
  }
}

variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "List of security rules"
  default = [
    {
      name                       = "SSH"
      priority                   = 1000
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "HTTP-8080"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

variable "admin_username" {
  type        = string
  default     = "az-user"
  description = "The username for the admin user"
}

variable "admin_password" {
  type        = string
  description = "The password for the admin user"
  sensitive   = true
}