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
  SBS_METERING_POINT_CONNECTED_TO_WHOLESALE_NAME = "metering-point-connected-to-wholesale"
  SBS_METERING_POINT_CONNECTED_TO_TIMESERIES_NAME = "metering-point-connected-to-timeseries"
}

module "sbt_metering_point_connected" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-topic?ref=7.0.0"

  name                = "metering-point-connected"
  namespace_id        = module.sb_domain_relay.id
  subscriptions       = [
    {
      name                = "market-roles-mp-connected-sub"
      max_delivery_count  = 10
      forward_to          = module.sbq_market_roles_forwarded.name
    },
    {
      name                = local.SBS_METERING_POINT_CONNECTED_TO_WHOLESALE_NAME
      max_delivery_count  = 10
    },
    {
      name                = local.SBS_METERING_POINT_CONNECTED_TO_TIMESERIES_NAME
      max_delivery_count  = 10
    },
  ]
}

module "kvs_sbt_metering_point_connected_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbt-metering-point-connected-name"
  value         = module.sbt_metering_point_connected.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_metering_point_connected_to_wholesale_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-metering-point-connected-to-wholesale-name"
  value         = local.SBS_METERING_POINT_CONNECTED_TO_WHOLESALE_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_metering_point_connected_to_timeseries_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-metering-point-connected-to-timeseries-name"
  value         = local.SBS_METERING_POINT_CONNECTED_TO_TIMESERIES_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}
