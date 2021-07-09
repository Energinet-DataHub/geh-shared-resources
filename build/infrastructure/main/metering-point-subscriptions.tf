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
resource "null_resource" "dependency_setter" {
  depends_on = [azurerm_servicebus_subscription.main]
}

#Queue to forward subscriptions to
module "sbq_market_roles_forwarded_queue" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-queue?ref=1.3.0"
  name                = "metering-point-forwarded_queue"
  namespace_name      = module.sbn_integrationevents.name
  resource_group_name = data.azurerm_resource_group.main.name
}

# Subscriptions
module "sbt_energy_supplier_changed_subscription" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-subscription?ref=1.3.0"
  name                = "metering-point"
  namespace_name      = module.sbn_integrationevents.name
  resource_group_name = data.azurerm_resource_group.main.name 
  topic_name          = module.sbt_energy_supplier_changed.name
  max_delivery_count  = 10
  forward_to          = module.sbq_metering_point_forwarded_queue.name
  depends_on          = [null_resource.dependency_getter]
}