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

variable "private_subnet_id" {
  type        = string
  description = "The ID of the private subnet"
}

variable "public_subnet_id" {
  type        = string
  description = "The ID of the public subnet"
}

variable "network_security_group_id" {
  type        = string
  description = "The ID of the network security group"
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
  description = "List of virtual machine configurations"
}

variable "admin_username" {
  type        = string
  description = "The admin username for the VM"
}

variable "admin_password" {
  type        = string
  description = "The admin password for the VM"
  sensitive   = true
}

variable "ssh_public_key" {
  type        = string
  description = "The SSH public key for the VM"
}