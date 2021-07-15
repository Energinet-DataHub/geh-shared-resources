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