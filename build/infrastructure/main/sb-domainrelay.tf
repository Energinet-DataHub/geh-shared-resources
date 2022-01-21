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
module "sb_domain_relay" {
  source                      = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-namespace?ref=6.0.0"

  name                        = "domain-relay"
  project_name                = var.domain_name_short
  environment_short           = var.environment_short
  environment_instance        = var.environment_instance
  resource_group_name         = azurerm_resource_group.this.name
  location                    = azurerm_resource_group.this.location
  private_endpoint_subnet_id  = module.private_endpoints_subnet.id
  vnet_resource_group_name    = azurerm_resource_group.this.name
  
  sku                         = "premium"
  auth_rules                  = [
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

  tags                        = azurerm_resource_group.this.tags
}

module "kvs_sb_domain_relay_listen_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sb-domain-relay-listen-connection-string"
  value         = module.sb_domain_relay.primary_connection_strings["listen"]
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sb_domain_relay_send_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sb-domain-relay-send-connection-string"
  value         = module.sb_domain_relay.primary_connection_strings["send"]
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sb_domain_relay_transceiver_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sb-domain-relay-transceiver-connection-string"
  value         = module.sb_domain_relay.primary_connection_strings["transceiver"]
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sb_domain_relay_manage_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sb-domain-relay-manage-connection-string"
  value         = module.sb_domain_relay.primary_connection_strings["manage"]
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}
