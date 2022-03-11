# Copyright 2020 Energinet DataHub A/S
#
# Licensed under the Apache License, Version 2.0 (the "License2");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Usefull resource for names
# https://gist.github.com/liamfoneill/f78698854d5dd23a9e6ab08ff044f38a

# Create the Storage account "blob" Private DNS Zone
resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name

  tags                = azurerm_resource_group.this.tags
}

# Create the Storage account "file" Private DNS Zone
resource "azurerm_private_dns_zone" "file" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name

  tags                = azurerm_resource_group.this.tags
}

# Create the Key Vault Private DNS Zone
resource "azurerm_private_dns_zone" "keyvault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.this.name

  tags                = azurerm_resource_group.this.tags
}

# Create the SQL database Private DNS Zone
resource "azurerm_private_dns_zone" "database" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.this.name

  tags                = azurerm_resource_group.this.tags
}

# Create the Service Bus Private DNS Zone
resource "azurerm_private_dns_zone" "servicebus" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name =  azurerm_resource_group.this.name

  tags                = azurerm_resource_group.this.tags
}

# Create the Cosmos "SQL API" Private DNS Zone
resource "azurerm_private_dns_zone" "cosmos" {
  name                = "privatelink.documents.azure.com"
  resource_group_name =  azurerm_resource_group.this.name

  tags                = azurerm_resource_group.this.tags
}

# Create the Azurewebsites Private DNS Zone
resource "azurerm_private_dns_zone" "azurewebsites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name =  azurerm_resource_group.this.name

  tags                = azurerm_resource_group.this.tags
}

# Create the Azurewebsites Private DNS Zone
resource "azurerm_private_dns_zone" "dfs" {
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name =  azurerm_resource_group.this.name

  tags                = azurerm_resource_group.this.tags
}