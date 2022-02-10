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
module "vnet_internal" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/vnet?ref=6.0.0"
  name                  = "internal"
  project_name          = var.domain_name_short
  environment_short     = var.environment_short
  environment_instance  = var.environment_instance
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  address_space         = []
  peerings              = [
    {
      name                                        = "internal"
      remote_virtual_network_id                   = data.azurerm_virtual_network.this.id
      remote_virtual_network_name                 = data.azurerm_virtual_network.this.name
      remote_virtual_network_resource_group_name  = data.azurerm_virtual_network.this.resource_group_name
      remote_virtual_network_subscription_id      = var.subscription_id
    }
  ]
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "internal_blob" {
  name                  = "pdnsz-internalblob-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = var.landing_zone_resource_group_name
  private_dns_zone_name = var.private_dns_zone_blob_name
  virtual_network_id    = module.vnet_internal.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "internal_db" {
  name                  = "pdnsz-internaldatabase-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = var.landing_zone_resource_group_name
  private_dns_zone_name = var.private_dns_zone_database_name
  virtual_network_id    = module.vnet_internal.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "internal_servicebus" {
  name                  = "pdnsz-internalservicebus-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = var.landing_zone_resource_group_name
  private_dns_zone_name = var.private_dns_zone_servicebus_name
  virtual_network_id    = module.vnet_internal.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "internal_keyvault" {
  name                  = "pdnsz-internalkeyvault-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = var.landing_zone_resource_group_name
  private_dns_zone_name = var.private_dns_zone_keyvault_name
  virtual_network_id    = module.vnet_internal.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "internal_cosmos" {
  name                  = "pdnsz-internalcosmos-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = var.landing_zone_resource_group_name
  private_dns_zone_name = var.private_dns_zone_cosmos_name
  virtual_network_id    = module.vnet_internal.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "internal_file" {
  name                  = "pdnsz-internalfile-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = var.landing_zone_resource_group_name
  private_dns_zone_name = var.private_dns_zone_file_name
  virtual_network_id    = module.vnet_internal.id

  tags                  = azurerm_resource_group.this.tags
}

module "kvs_vnet_internal_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.5.0"

  name          = "vnet-internal-name"
  value         = module.vnet_internal.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_vnet_internal_id" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.5.0"

  name          = "vnet-internal-id"
  value         = module.vnet_internal.id
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_vnet_internal_resource_group_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.5.0"

  name          = "vnet-internal-resource-group-name"
  value         = azurerm_resource_group.this.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}
