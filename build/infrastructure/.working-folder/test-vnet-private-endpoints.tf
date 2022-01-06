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
resource "azurerm_storage_account" "test" {
  name                      = "sttest${lower(var.domain_name_short)}${lower(var.environment_short)}${lower(var.environment_instance)}"
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  account_tier              = "Standard"
  account_replication_type  = "GRS"


  tags                      = azurerm_resource_group.this.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

# Create input container
 resource "azurerm_storage_container" "input" {
   name                  = "input"
   container_access_type = "private"
   storage_account_name  = azurerm_storage_account.test.name
 }

resource "azurerm_storage_account_network_rules" "test" {
  resource_group_name  = azurerm_resource_group.this.name
  storage_account_name = azurerm_storage_account.test.name

  default_action             = "Deny"
  ip_rules                   = [
    "127.0.0.1"
  ]
  virtual_network_subnet_ids = [
    azurerm_subnet.this_vnet_integrations.id
  ]
  bypass                     = [
    "Metrics"
  ]
}

resource "azurerm_private_endpoint" "endpoint" {
   name                = "sa-endpoint"
   location            = azurerm_resource_group.this.location
   resource_group_name = azurerm_resource_group.this.name
   subnet_id           = azurerm_subnet.this_private_endpoints_subnet.id
   private_service_connection {
     name                           = "sa-privateserviceconnection"
     private_connection_resource_id = azurerm_storage_account.test.id
     is_manual_connection           = false
     subresource_names              = ["blob"]
  }
}

