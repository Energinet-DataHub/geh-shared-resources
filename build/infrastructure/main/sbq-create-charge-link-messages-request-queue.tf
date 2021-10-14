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

# Create create link messages request queue
module "sbq_create_link_messages_request" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-queue?ref=2.0.0"
  name                = "create-link-messages-request"
  namespace_name      = module.sbn_integrationevents.name
  resource_group_name = data.azurerm_resource_group.main.name
  dependencies        = [
    module.sbn_integrationevents.dependent_on,
  ]
}

# Create create link messages reply queue
module "sbq_create_link_messages_reply" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-queue?ref=2.0.0"
  name                = "create-link-messages-reply"
  namespace_name      = module.sbn_integrationevents.name
  resource_group_name = data.azurerm_resource_group.main.name
  dependencies        = [
    module.sbn_integrationevents.dependent_on,
  ]
}