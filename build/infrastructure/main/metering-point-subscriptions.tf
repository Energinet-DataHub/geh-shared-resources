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
module "sbq_metering_point_forwarded_queue" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-queue?ref=1.9.0"
  name                = "metering-point-forwarded-queue"
  namespace_name      = module.sbn_integrationevents.name
  resource_group_name = data.azurerm_resource_group.main.name
  dependencies        = [
    module.sbn_integrationevents.dependent_on
  ]
}

# Subscriptions
module "sbs_energy_supplier_changed_subscription" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-subscription?ref=1.9.0"
  name                = "metering-point-energy-supplier-changed-sub"
  namespace_name      = module.sbn_integrationevents.name
  resource_group_name = data.azurerm_resource_group.main.name 
  topic_name          = module.sbt_energy_supplier_changed.name
  max_delivery_count  = 10
  forward_to          = module.sbq_metering_point_forwarded_queue.name
  dependencies        = [ module.sbn_integrationevents.dependent_on, 
    module.sbq_metering_point_forwarded_queue.dependent_on,
    module.sbt_energy_supplier_changed.dependent_on]
}

# Add sbq_meterig_point_forwarded_queue name to key vault to be able to fetch that out in the metering point repo
module "kv_metering_point_forwarded_queue_name" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.9.0"
  name                = "METERING-POINT-FORWARDED-QUEUE-NAME"
  value               = module.sbq_metering_point_forwarded_queue.name
  key_vault_id        = module.kv.id
  tags                = data.azurerm_resource_group.main.tags
  dependencies        = [
    module.kv.dependent_on,
    module.sbq_metering_point_forwarded_queue.dependent_on
  ]
}