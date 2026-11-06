variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-sunita"
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-sunita"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the subnet for the private endpoint"
  type        = string
  default     = "snet-private-endpoint"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the private endpoint subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_endpoint_name" {
  description = "Name of the private endpoint"
  type        = string
  default     = "pe-sunita"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default = {
    Environment = "Practice"
    ManagedBy   = "Terraform"
  }
}

