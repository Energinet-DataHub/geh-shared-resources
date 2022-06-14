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
locals {
  SBS_ENERGY_SUPPLIER_CHANGE_TO_AGGREGATIONS_NAME = "energy-supplier-change-to-aggregations"
  SBS_ENERGY_SUPPLIER_CHANGED_TO_MESSAGING_NAME = "energy-supplier-changed-to-messaging"
}

module "sbt_energy_supplier_changed" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-topic?ref=6.0.0"

  name                = "energy-supplier-changed"
  namespace_id        = module.sb_domain_relay.id
  subscriptions       = [
    {
      name                = "metering-point-energy-supplier-changed-sub"
      max_delivery_count  = 10
      forward_to          = module.sbq_metering_point_forwarded.name
    },
    {
      name                = local.SBS_ENERGY_SUPPLIER_CHANGE_TO_AGGREGATIONS_NAME
      max_delivery_count  = 10
    },
    {
      name                = local.SBS_ENERGY_SUPPLIER_CHANGED_TO_MESSAGING_NAME
      max_delivery_count  = 10
    },
  ]
}

module "kvs_sbt_energy_supplier_changed_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sbt-energy-supplier-changed-name"
  value         = module.sbt_energy_supplier_changed.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_energy_supplier_change_to_aggregations_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sbs-energy-supplier-change-to-aggregations-name"
  value         = local.SBS_ENERGY_SUPPLIER_CHANGE_TO_AGGREGATIONS_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_energy_supplier_changed_to_messaging_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sbs-energy-supplier-changed-to-messaging-name"
  value         = local.SBS_ENERGY_SUPPLIER_CHANGED_TO_MESSAGING_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}