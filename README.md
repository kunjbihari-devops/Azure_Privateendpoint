# Azure Resource Group & Private Endpoint Infrastructure

This Terraform practice project provisions an Azure Resource Group in `eastus` along with a fully configured **Private Endpoint** and its required supporting infrastructure.

## Architecture Overview

In Azure, a **Private Endpoint** requires:
1. **Resource Group**: `rg-sunita` in `eastus`.
2. **Virtual Network**: `vnet-sunita` with address prefix `10.0.0.0/16`.
3. **Subnet**: `snet-private-endpoint` (`10.0.1.0/24`) configured to host private endpoints.
4. **Target Resource**: Azure Storage Account (`stsunita<random>`) configured with a private service connection.
5. **Private DNS Zone & Link**: `privatelink.blob.core.windows.net` linked to the VNet for automatic DNS name resolution.
6. **Private Endpoint**: `pe-sunita` securely routing blob traffic through private IP in the subnet.

---

## File Structure

- [`providers.tf`](./providers.tf): Defines AzureRM and Random provider configurations.
- [`variables.tf`](./variables.tf): Input variables for names, CIDRs, tags, and region.
- [`terraform.tfvars`](./terraform.tfvars): Configured input values for the deployment.
- [`main.tf`](./main.tf): Resources definition (Resource Group, VNet, Subnet, Storage Account, DNS Zone, and Private Endpoint).
- [`outputs.tf`](./outputs.tf): Outputs including resource IDs, names, and private IP.

---

## Deployment Steps

1. **Log in to Azure CLI**:
   ```bash
   az login
   az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Check Execution Plan**:
   ```bash
   terraform plan
   ```

4. **Apply Configuration**:
   ```bash
   terraform apply
   ```

5. **Clean Up / Destroy Resources**:
   ```bash
   terraform destroy
   ```

