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
module "sbt_metering_point_connected" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-topic?ref=renetnielsen/3.1.0"

  name                = "metering-point-connected"
  namespace_name      = module.sb_communication.name
  resource_group_name = azurerm_resource_group.this.name
  subscriptions       = [
    {
      name                = "metering-point-energy-supplier-changed-sub"
      max_delivery_count  = 10
      forward_to          = module.sbq_metering_point_forwarded_queue.name
    },
  ]

  dependencies        = [
    module.sb_communication.dependent_on,
  ]
}