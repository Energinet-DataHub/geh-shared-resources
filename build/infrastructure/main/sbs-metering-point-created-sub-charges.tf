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

resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}
resource "null_resource" "dependency_setter" {
  depends_on = [azurerm_servicebus_subscription.main]
}

resource "azurerm_servicebus_subscription" "sbs_metering_point_created_charges" {
  depends_on          = [null_resource.dependency_getter]
  name                = "metering-point-created-sub-charges"
  resource_group_name = data.azurerm_resource_group.main.name
  namespace_name      = module.sbn_integrationevents.name
  topic_name          = module.sbt_metering_point_created.name
  max_delivery_count  = 1
}

module "sbt_metering_point_created_charges" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-topic?ref=1.3.0"
  name                = "metering-point-created-charges"
  resource_group_name = data.azurerm_resource_group.main.name
  namespace_name      = module.sbn_integrationevents.name
}

module "sbtar_metering_point_created_charges_listener" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-topic-auth-rule?ref=1.3.0"
  name                = "metering-point-created-charges-listener"
  namespace_name      = module.sbn_integrationevents.name
  topic_name          = module.sbt_metering_point_created_charges.name
  resource_group_name = data.azurerm_resource_group.main.name
  listen              = true
}

module "kv_metering_point_created_charges_listener_connection_string" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.3.0"
  name                = "metering-point-created-charges-listener-connection-string"
  value               = trimsuffix(module.sbtar_metering_point_created_charges_listener.primary_connection_string, ";EntityPath=${module.sbt_metering_point_created.name}")
  key_vault_id        = module.kv.id
  tags                = data.azurerm_resource_group.main.tags
  dependencies        = [module.kv.dependent_on, module.sbtar_metering_point_created_charges_listener.dependent_on]
}
