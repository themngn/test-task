variable "prefix" {
  type        = string
  description = "The prefix for the resources"
}

variable "location" {
  type        = string
  description = "The Azure location"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
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
}