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
module "sb_domainrelay" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-namespace?ref=4.1.0"

  name                  = "domainrelay"
  environment_short     = var.environment_short
  environment_instance  = var.environment_instance
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  sku                   = "standard"
  auth_rules            = [
    {
      name    = "listen",
      listen  = true
    },
    {
      name    = "send",
      send    = true
    },
    {
      name    = "transceiver",
      send    = true
      listen  = true
    },
    {
      name    = "manage",
      send    = true
      listen  = true
      manage  = true
    },
  ]

  tags                  = local.tags
}

module "kvs_sb_domainrelay_send_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=4.1.0"

  name          = "sb-communications-listen-connection-string"
  value         = module.sb_domainrelay.primary_connection_strings["listen"]
  key_vault_id  = module.kv_shared.id
}

module "kvs_sb_domainrelay_listen_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=4.1.0"

  name          = "sb-communications-send-connection-string"
  value         = module.sb_domainrelay.primary_connection_strings["send"]
  key_vault_id  = module.kv_shared.id
}

module "kvs_sb_domainrelay_transceiver_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=4.1.0"

  name          = "sb-communications-transceiver-connection-string"
  value         = module.sb_domainrelay.primary_connection_strings["transceiver"]
  key_vault_id  = module.kv_shared.id
}

module "kvs_sb_domainrelay_manage_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=4.1.0"

  name          = "sb-communications-manage-connection-string"
  value         = module.sb_domainrelay.primary_connection_strings["manage"]
  key_vault_id  = module.kv_shared.id
}
