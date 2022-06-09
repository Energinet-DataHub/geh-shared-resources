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
  SBS_MARKET_PARTICIPANT_TO_CHARGES_NAME = "market-participant-changed-to-charges"
  SBS_MARKET_PARTICIPANT_TO_AGGREGATIONS_NAME = "market-participant-changed-to-aggregations"
  SBS_MARKET_PARTICIPANT_TO_TIMESERIES_NAME = "market-participant-changed-to-timeseries"
  SBS_MARKET_PARTICIPANT_TO_METERINGPOINT_NAME = "market-participant-changed-to-meteringpoint"
  SBS_MARKET_PARTICIPANT_TO_MARKETROLES_NAME = "market-participant-changed-to-marketroles"
  SBS_MARKET_PARTICIPANT_TO_MESSAGEHUB_NAME = "market-participant-changed-to-messagehub"
}

module "sbt_market_participant_changed" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-topic?ref=7.0.0"

  name                = "market-participant-changed"
  namespace_id        = module.sb_domain_relay.id
  subscriptions       = [
    {
      name                = local.SBS_MARKET_PARTICIPANT_TO_CHARGES_NAME
      max_delivery_count  = 10
    },
    {
      name                = local.SBS_MARKET_PARTICIPANT_TO_AGGREGATIONS_NAME
      max_delivery_count  = 10
    },
    {
      name                = local.SBS_MARKET_PARTICIPANT_TO_TIMESERIES_NAME
      max_delivery_count  = 10
    },
    {
      name                = local.SBS_MARKET_PARTICIPANT_TO_METERINGPOINT_NAME
      max_delivery_count  = 10
    },
    {
      name                = local.SBS_MARKET_PARTICIPANT_TO_MARKETROLES_NAME
      max_delivery_count  = 10
    },
    {
      name                = local.SBS_MARKET_PARTICIPANT_TO_MESSAGEHUB_NAME
      max_delivery_count  = 10
    },
  ]
}

module "kvs_sbt_market_participant_changed_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbt-market-participant-changed-name"
  value         = module.sbt_market_participant_changed.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_market_participant_changed_to_charges_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-market-participant-changed-to-charges-name"
  value         = local.SBS_MARKET_PARTICIPANT_TO_CHARGES_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_market_participant_changed_to_aggregations_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-market-participant-changed-to-aggregations-name"
  value         = local.SBS_MARKET_PARTICIPANT_TO_AGGREGATIONS_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_market_participant_changed_to_timeseries_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-market-participant-changed-to-timeseries-name"
  value         = local.SBS_MARKET_PARTICIPANT_TO_TIMESERIES_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_market_participant_changed_to_meteringpoint_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-market-participant-changed-to-meteringpoint-name"
  value         = local.SBS_MARKET_PARTICIPANT_TO_METERINGPOINT_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_market_participant_changed_to_marketroles_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-market-participant-changed-to-marketroles-name"
  value         = local.SBS_MARKET_PARTICIPANT_TO_MARKETROLES_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sbs_market_participant_changed_to_messagehub_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "sbs-market-participant-changed-to-messagehub-name"
  value         = local.SBS_MARKET_PARTICIPANT_TO_MESSAGEHUB_NAME
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}