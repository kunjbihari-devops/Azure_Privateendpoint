# 1. Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# 2. Virtual Network (Required for Private Endpoint)
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# 3. Subnet for Private Endpoint
resource "azurerm_subnet" "pe_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefixes

  # In azurerm v3.x, disabled allows private endpoint network policies
  private_endpoint_network_policies = "Disabled"
}

# 4. Target PaaS Service: Azure Storage Account
resource "random_string" "random_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "sa" {
  name                     = "stsunita${random_string.random_suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Recommended practice when using Private Endpoints
  public_network_access_enabled = true

  tags = var.tags
}

# 5. Private DNS Zone (Recommended for Private Endpoints resolution)
resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}

# 6. Link Private DNS Zone with Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "vnet-link-${var.vnet_name}"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  tags                  = var.tags
}

# 7. Azure Private Endpoint
resource "azurerm_private_endpoint" "pe" {
  name                = var.private_endpoint_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.pe_subnet.id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-${var.private_endpoint_name}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.sa.id
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "dns-group-${var.private_endpoint_name}"
    private_dns_zone_ids = [azurerm_private_dns_zone.dns_zone.id]
  }
}

