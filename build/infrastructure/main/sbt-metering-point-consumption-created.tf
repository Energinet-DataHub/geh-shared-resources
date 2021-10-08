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

module "sbt_consumption_metering_point_created" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-topic?ref=2.0.0"
  name                = "consumption-metering-point-created"
  namespace_name      = module.sbn_integrationevents.name
  resource_group_name = data.azurerm_resource_group.main.name
  dependencies        = [
    module.sbn_integrationevents.dependent_on
  ]
}

module "sbs_consumption_metering_point_created_charge" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-subscription?ref=2.0.0"
  name                = "consumption-metering-point-created-sub-charges"
  resource_group_name = data.azurerm_resource_group.main.name
  namespace_name      = module.sbn_integrationevents.name
  topic_name          = module.sbt_consumption_metering_point_created.name
  max_delivery_count  = 1
  dependencies        = [
    module.sbt_consumption_metering_point_created.dependent_on,
    module.sbn_integrationevents.dependent_on,
  ]
}

module "sbs_consumption_metering_point_created_subscription_market_roles" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-subscription?ref=1.9.0"
  name                = "market-roles-consumption-metering-point-created-sub"
  namespace_name      = module.sbn_integrationevents.name
  resource_group_name = data.azurerm_resource_group.main.name 
  topic_name          = module.sbt_consumption_metering_point_created.name
  max_delivery_count  = 10
  forward_to          = module.sbq_market_roles_forwarded_queue.name
  dependencies        = [ 
    module.sbn_integrationevents.dependent_on, 
    module.sbq_market_roles_forwarded_queue.dependent_on,
    module.sbt_consumption_metering_point_created.dependent_on
  ]
}