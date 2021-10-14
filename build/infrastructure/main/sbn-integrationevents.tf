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
  name                      = "sbnar-integrationevents-listen"

  namespace_name            = module.sbn_integrationevents.name
  resource_group_name       = data.azurerm_resource_group.main.name
  listen                    = true

  dependencies              = [
    module.sbn_integrationevents.dependent_on,
  ]
}

module "sbnar_integrationevents_send" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-namespace-auth-rule?ref=1.9.0"
  name                      = "sbnar-integrationevents-send"

  namespace_name            = module.sbn_integrationevents.name
  resource_group_name       = data.azurerm_resource_group.main.name
  send                      = true

  dependencies              = [
    module.sbn_integrationevents.dependent_on,
  ]
}

module "sbnar_integrationevents_transceiver" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//service-bus-namespace-auth-rule?ref=1.9.0"
  name                      = "sbnar-integrationevents-sendlisten"

  namespace_name            = module.sbn_integrationevents.name
  resource_group_name       = data.azurerm_resource_group.main.name
  listen                    = true
  send                      = true

  dependencies              = [
    module.sbn_integrationevents.dependent_on,
  ]
}

module "kvs_integrationevents_send" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=2.0.0"

  name          = "SHARED-RESOURCES--SB-INTEGRATIONEVENTS-LISTEN-CONNECTION-STRING"
  value         = module.sbnar_integrationevents_listen.primary_connection_string
  key_vault_id  = module.kv.id

  dependencies  = [
    module.sqlsrv.dependent_on,
  ]
}

module "kvs_integrationevents_listen" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=2.0.0"

  name          = "SHARED-RESOURCES--SB-INTEGRATIONEVENTS-SEND-CONNECTION-STRING"
  value         = module.sbnar_integrationevents_send.primary_connection_string
  key_vault_id  = module.kv.id

  dependencies  = [
    module.sqlsrv.dependent_on,
  ]
}

module "kvs_integrationevents_transceiver" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=2.0.0"

  name          = "SHARED-RESOURCES--SB-INTEGRATIONEVENTS-TRANSCEIVER-CONNECTION-STRING"
  value         = module.sbnar_integrationevents_transceiver.primary_connection_string
  key_vault_id  = module.kv.id

  dependencies  = [
    module.sqlsrv.dependent_on,
  ]
}
