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
module "sbn_integrationevents" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-namespace?ref=1.9.0"
  name                = "sbn-integrationevents-${var.project}-${var.organisation}-${var.environment}"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  sku                 = "basic"
  tags                = data.azurerm_resource_group.main.tags
}

module "sbnar_integrationevents_listen" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-namespace-auth-rule?ref=1.9.0"
  name                      = "sbnar-integrationevents-listener"
  namespace_name            = module.sbn_integrationevents.name
  resource_group_name       = data.azurerm_resource_group.main.name
  listen                    = true
  dependencies              = [
    module.sbn_integrationevents.dependent_on
  ]
}

module "sbnar_integrationevents_send" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-namespace-auth-rule?ref=1.9.0"
  name                      = "sbnar-integrationevents-sender"
  namespace_name            = module.sbn_integrationevents.name
  resource_group_name       = data.azurerm_resource_group.main.name
  send                      = true
  dependencies              = [
    module.sbn_integrationevents.dependent_on
  ]
}

module "sbnar_integrationevents_sendlisten" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-namespace-auth-rule?ref=1.9.0"
  name                      = "sbnar-integrationevents-messagehub"
  namespace_name            = module.sbn_integrationevents.name
  resource_group_name       = data.azurerm_resource_group.main.name
  listen                    = true
  send                      = true
  dependencies              = [
    module.sbn_integrationevents.dependent_on
  ]
}

module "kvs_integrationevents_listen_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.6.0"
  name          = "INTEGRATION_EVENTS_LISTENER_CONNECTION_STRING"
  value         = module.sbnar_integrationevents_listen.primary_connection_string
  key_vault_id  = module.kv.id
  dependencies  = [
    module.sbnar_integrationevents_listen.dependent_on,
  ]
}

module "kvs_integrationevents_send_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.6.0"
  name          = "INTEGRATION-EVENTS-SENDER-CONNECTION-STRING"
  value         = module.sbnar_integrationevents_send.primary_connection_string
  key_vault_id  = module.kv.id
  dependencies  = [
    module.sbnar_integrationevents_send.dependent_on,
  ]
}

module "kvs_integrationevents_sendlisten_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.6.0"
  name          = "INTEGRATION-EVENTS-SENDLISTEN-CONNECTION-STRING"
  value         = module.sbnar_integrationevents_sendlisten.primary_connection_string
  key_vault_id  = module.kv.id
  dependencies  = [
    module.sbnar_integrationevents_sendlisten.dependent_on,
  ]
}

module "kvs_integrationevents_listen_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.6.0"
  name          = "INTEGRATION-EVENTS-LISTENER-CONNECTION-STRING"
  value         = module.sbnar_integrationevents_listen.primary_connection_string
  key_vault_id  = module.kv.id
  dependencies  = [
    module.sbnar_integrationevents_listen.dependent_on,
  ]
}

module "kvs_integrationevents_send_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.6.0"
  name          = "INTEGRATION-EVENTS-SENDER-CONNECTION-STRING"
  value         = module.sbnar_integrationevents_send.primary_connection_string
  key_vault_id  = module.kv.id
  dependencies  = [
    module.sbnar_integrationevents_send.dependent_on,
  ]
}

module "kvs_integrationevents_sendlisten_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.6.0"
  name          = "INTEGRATION-EVENTS-SENDLISTEN-CONNECTION-STRING"
  value         = module.sbnar_integrationevents_sendlisten.primary_connection_string
  key_vault_id  = module.kv.id
  dependencies  = [
    module.sbnar_integrationevents_sendlisten.dependent_on,
  ]
}

