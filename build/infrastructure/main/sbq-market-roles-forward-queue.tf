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

# Queue to forward subscriptions to
module "sbq_market_roles_forwarded_queue" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-queue?ref=2.0.0"
  name                = "market-roles-forwarded-queue"
  namespace_name      = module.sbn_integrationevents.name
  resource_group_name = data.azurerm_resource_group.main.name
  dependencies        = [
    module.sbn_integrationevents.dependent_on
  ]
}

# Subscriptions
module "sbs_metering_point_connected_subscription_market_roles" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-subscription?ref=2.0.0"
  name                = "market-roles-metering-point-connected-sub"
  namespace_name      = module.sbn_integrationevents.name
  resource_group_name = data.azurerm_resource_group.main.name 
  topic_name          = module.sbt_metering_point_connected.name
  max_delivery_count  = 10
  forward_to          = module.sbq_market_roles_forwarded_queue.name
  dependencies        = [ 
    module.sbn_integrationevents.dependent_on, 
    module.sbq_market_roles_forwarded_queue.dependent_on,
    module.sbt_metering_point_connected.dependent_on
  ]
}

# Add sbq_market_roles_forwarded_queue name to key vault to be able to fetch that out in the market roles repo
module "kv_market_roles_forwarded_queue_name" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=2.0.0"
  name                = "MARKET-ROLES-FORWARDED-QUEUE-NAME"
  value               = module.sbq_market_roles_forwarded_queue.name
  key_vault_id        = module.kv.id
  tags                = data.azurerm_resource_group.main.tags
  dependencies        = [
    module.kv.dependent_on,
    module.sbq_market_roles_forwarded_queue.dependent_on
  ]
}