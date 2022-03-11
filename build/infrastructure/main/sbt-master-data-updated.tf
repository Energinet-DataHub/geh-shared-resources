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

module "sbt_master_data_updated" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-topic?ref=5.1.0"

  name                = "master-data-updated"
  namespace_name      = module.sb_domain_relay.name
  resource_group_name = azurerm_resource_group.this.name
  subscriptions       = []
}

module "kvs_sbt_master_data_updated" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.1.0"

  name          = "sbt-master-data-updated-name"
  value         = module.sbt_master_data_updated.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}