output "virtual_network_name" {
  value       = azurerm_virtual_network.main.name
  sensitive   = true
  description = "The name of the virtual network"
  depends_on  = []
}

output "private_subnet_id" {
  value       = azurerm_subnet.internal.id
  sensitive   = true
  description = "The ID of the private subnet"
  depends_on  = []
}

output "public_subnet_id" {
  value       = azurerm_subnet.public.id
  sensitive   = true
  description = "The ID of the public subnet"
  depends_on  = []
}

output "network_security_group_id" {
  value       = azurerm_network_security_group.public.id
  sensitive   = true
  description = "The ID of the network security group"
  depends_on  = []
}