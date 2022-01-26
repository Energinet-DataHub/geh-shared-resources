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
module "vnet_main" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/vnet?ref=6.0.0"
  name                  = "main"
  project_name          = var.domain_name_short
  environment_short     = var.environment_short
  environment_instance  = var.environment_instance
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  address_space         = ["10.42.0.0/23"]
  peerings              = [
    {
      name                        = "landingzone"
      remote_virtual_network_id   = var.landingzone_virtual_network_id
      remote_resource_group_name  = var.landingzone_resource_group_name
    }
  ]
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = "pdnsz-blob-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = var.private_dns_zone_blob_name
  virtual_network_id    = module.vnet_main.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "db" {
  name                  = "pdnsz-database-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = var.private_dns_zone_database_name
  virtual_network_id    = module.vnet_main.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "servicebus" {
  name                  = "pdnsz-servicebus-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = var.private_dns_zone_servicebus_name
  virtual_network_id    = module.vnet_main.id

  tags                  = azurerm_resource_group.this.tags
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "vault" {
  name                  = "pdnsz-keyvault-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = var.private_dns_zone_keyvault_name
  virtual_network_id    = module.vnet_main.id

  tags                  = azurerm_resource_group.this.tags
}

module "kvs_vnet_shared_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "vnet-shared-name"
  value         = module.vnet_main.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_vnet_shared_rg_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "vnet-shared-rg-name"
  value         = azurerm_resource_group.this.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}