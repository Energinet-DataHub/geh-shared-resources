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
module "evhnm_integration_event" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//event-hub-namespace?ref=1.9.0"
  name                      = "evhnm-integration-event-${var.project}-${var.organisation}-${var.environment}"
  resource_group_name       = data.azurerm_resource_group.main.name
  location                  = data.azurerm_resource_group.main.location
  sku                       = "Standard"
  capacity                  = 1
  tags                      = data.azurerm_resource_group.main.tags
}

module "evhar_integration_event" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//event-hub-auth-rule?ref=1.9.0"
  name                      = "evhar-integration-event"
  namespace_name            = module.evhnm_integration_event.name
  eventhub_name             = module.evh_integration_event.name
  resource_group_name       = data.azurerm_resource_group.main.name
  send                      = true
  listen                    = true
}

module "kvs_integration_event_connection_string" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.9.0"
  name                      = "EVHAR-INTEGRATION-EVENTS-LISTENER-CONNECTION-STRING"
  value                     = module.evhar_integration_event.primary_connection_string
  key_vault_id              = module.kv.id
}
