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

module "kvs_vnet_shared_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "vnet-name"
  value         = data.azurerm_virtual_network.this.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_vnet_shared_id" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "vnet-id"
  value         = data.azurerm_virtual_network.this.id
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_vnet_shared_resource_group_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "vnet-resource-group-name"
  value         = data.azurerm_virtual_network.this.resource_group_name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}
