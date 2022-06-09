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
  SBS_METERING_POINT_SUB_CHARGES_NAME = "metering-point-created-sub-charges"
  SBS_METERING_POINT_TO_AGGREGATIONS_NAME = "metering-point-created-to-aggregations"
  SBS_METERING_POINT_TO_TIMESERIES_NAME = "metering-point-created-to-timeseries"
}

module "sbt_metering_point_created" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-topic?ref=7.0.0"

  name                = "metering-point-created"
  namespace_id        = module.sb_domain_relay.id
  subscriptions       = [
    {
      name                = local.SBS_METERING_POINT_SUB_CHARGES_NAME
      max_delivery_count  = 1
    },
    {
      name                = "market-roles-mp-created-sub"
      max_delivery_count  = 10
      forward_to          = module.sbq_market_roles_forwarded.name
    },
    {
      name                = local.SBS_METERING_POINT_TO_AGGREGATIONS_NAME
      max_delivery_count  = 10
    },
    {
      name                = local.SBS_METERING_POINT_TO_TIMESERIES_NAME
      max_delivery_count  = 10
    },
  ]
}

module "kvs_sbt_metering_point_created_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbt-metering-point-created-name"
  value         = module.sbt_metering_point_created.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_metering_point_created_sub_charges_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-metering-point-created-sub-charges-name"
  value         = local.SBS_METERING_POINT_SUB_CHARGES_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_metering_point_created_to_aggregations_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-metering-point-created-to-aggregations-name"
  value         = local.SBS_METERING_POINT_TO_AGGREGATIONS_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_metering_point_created_to_timeseries_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-metering-point-created-to-timeseries-name"
  value         = local.SBS_METERING_POINT_TO_TIMESERIES_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}