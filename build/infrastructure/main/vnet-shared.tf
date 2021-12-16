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
resource "azurerm_virtual_network" "this" {
  name                = "vnet-shared-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags                = azurerm_resource_group.this.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_subnet" "this_vnet_integrations" {
  name                                          = "snet-vnetintegrations-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name                           = azurerm_resource_group.this.name
  virtual_network_name                          = azurerm_virtual_network.this.name
  address_prefixes                              = ["10.0.1.0/24"]
  enforce_private_link_service_network_policies = true

  delegation {
    name = "delegation"
 
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }

  tags                = azurerm_resource_group.this.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_subnet" "this_external_endpoints" {
  name                                            = "snet-externalendpoints-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name                             = azurerm_resource_group.this.name
  virtual_network_name                            = azurerm_virtual_network.this.name
  address_prefixes                                = ["10.0.1.0/24"]
  enforce_private_link_endpoint_network_policies  = true

  delegation {
    name = "delegation"
 
    service_delegation {
    }
  }

  tags                                             = azurerm_resource_group.this.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

resource "azurerm_subnet" "this_private_endpoints" {
  name                                            = "snet-privateendpoints-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name                             = azurerm_resource_group.this.name
  virtual_network_name                            = azurerm_virtual_network.this.name
  address_prefixes                                = ["10.0.1.0/24"]
  enforce_private_link_endpoint_network_policies  = true

  delegation {
    name = "delegation"
 
    service_delegation {
    }
  }

  tags                                             = azurerm_resource_group.this.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}