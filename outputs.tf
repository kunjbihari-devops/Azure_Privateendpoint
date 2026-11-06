output "resource_group_name" {
  description = "The name of the Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "The ID of the Resource Group"
  value       = azurerm_resource_group.rg.id
}

output "resource_group_location" {
  description = "The location of the Resource Group"
  value       = azurerm_resource_group.rg.location
}

output "virtual_network_name" {
  description = "The name of the Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_name" {
  description = "The name of the Subnet"
  value       = azurerm_subnet.pe_subnet.name
}

output "storage_account_name" {
  description = "The name of the Storage Account connected via Private Endpoint"
  value       = azurerm_storage_account.sa.name
}

output "private_endpoint_id" {
  description = "The ID of the Private Endpoint"
  value       = azurerm_private_endpoint.pe.id
}

output "private_endpoint_private_ip" {
  description = "Private IP address assigned to the Private Endpoint"
  value       = azurerm_private_endpoint.pe.private_service_connection[0].private_ip_address
}

