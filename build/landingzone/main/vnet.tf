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
data "azurerm_virtual_network" "this" {
  name                = var.virtual_network_name
  resource_group_name = var.virtual_network_resource_group_name
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = "pdnsz-blob-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = data.azurerm_virtual_network.this.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "db" {
  name                  = "pdnsz-database-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.database.name
  virtual_network_id    = data.azurerm_virtual_network.this.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "servicebus" {
  name                  = "pdnsz-servicebus-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.servicebus.name
  virtual_network_id    = data.azurerm_virtual_network.this.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "keyvault" {
  name                  = "pdnsz-keyvault-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.keyvault.name
  virtual_network_id    = data.azurerm_virtual_network.this.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "cosmos" {
  name                  = "pdnsz-cosmos-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.cosmos.name
  virtual_network_id    = data.azurerm_virtual_network.this.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "file" {
  name                  = "pdnsz-file-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.file.name
  virtual_network_id    = data.azurerm_virtual_network.this.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites" {
  name                  = "pdnsz-azurewebsites-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.azurewebsites.name
  virtual_network_id    = data.azurerm_virtual_network.this.id

  tags                  = azurerm_resource_group.this.tags
}