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

# Create the blob.core.windows.net Private DNS Zone
resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = "${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}-bloblink"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = var.azurerm_virtual_network_name
}

# Create the database.windows.net Private DNS Zone
resource "azurerm_private_dns_zone" "database" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.this.name
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "db" {
  name                  = "${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}-dblink"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.database.name
  virtual_network_id    = var.azurerm_virtual_network_name
}

# Create the servicebuswindows.net Private DNS Zone
resource "azurerm_private_dns_zone" "servicebus" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name =  azurerm_resource_group.this.name
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "servicebus" {
  name                  = "${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}-servicebuslink"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.servicebus.name
  virtual_network_id    = var.azurerm_virtual_network_name
}

# Create the keyvault  Private DNS Zone
resource "azurerm_private_dns_zone" "keyvault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.this.name
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "vault" {
  name                  = "${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}-vaultlink"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.keyvault.name
  virtual_network_id    = var.azurerm_virtual_network_name
}