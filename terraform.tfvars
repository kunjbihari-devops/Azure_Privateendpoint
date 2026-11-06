resource_group_name     = "rg-sunita"
location                = "eastus"
vnet_name               = "vnet-sunita"
vnet_address_space      = ["10.0.0.0/16"]
subnet_name             = "snet-private-endpoint"
subnet_address_prefixes = ["10.0.1.0/24"]
private_endpoint_name   = "pe-sunita"
tags = {
  Environment = "Practice"
  Owner       = "Sunita"
  ManagedBy   = "Terraform"
}

