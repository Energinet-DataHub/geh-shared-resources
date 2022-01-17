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
  
  # Delegate the subnet to "Microsoft.Web/serverFarms"
  delegation {
   name = "acctestdelegation"
   service_delegation {
     name    = "Microsoft.Web/serverFarms"
     actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
   }
  }
  
service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "this_private_endpoints_subnet" {
  name                                            = "snet-privateendpoints-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name                             = azurerm_resource_group.this.name
  virtual_network_name                            = azurerm_virtual_network.this.name
  address_prefixes                                = ["10.0.2.0/24"]
  enforce_private_link_endpoint_network_policies  = true
  enforce_private_link_service_network_policies = true
}

resource "azurerm_subnet" "this_external_endpoints_subnet" {
  name                                            = "snet-externalendpoints-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name                             = azurerm_resource_group.this.name
  virtual_network_name                            = azurerm_virtual_network.this.name
  address_prefixes                                = ["10.0.3.0/24"]
  enforce_private_link_endpoint_network_policies  = true

  lifecycle {
    ignore_changes = [
    ]
  }
}

# https://gist.github.com/liamfoneill/f78698854d5dd23a9e6ab08ff044f38a

# Create the blob.core.windows.net Private DNS Zone
resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.this.name
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  name                  = "${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}-bloblink"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.blob.name
  virtual_network_id    = azurerm_virtual_network.this.id
}

# Create the database.windows.net Private DNS Zone
resource "azurerm_private_dns_zone" "database" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.this.name
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "db" {
  name                  = "${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}-dblink"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.database.name
  virtual_network_id    = azurerm_virtual_network.this.id
}

# Create the servicebuswindows.net Private DNS Zone
resource "azurerm_private_dns_zone" "servicebus" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name =  azurerm_resource_group.this.name
}

# Link the Private Zone with the VNet
resource "azurerm_private_dns_zone_virtual_network_link" "servicebus" {
  name                  = "${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}-servicebuslink"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.servicebus.name
  virtual_network_id    = azurerm_virtual_network.this.id
}

# module "kvs_vnet_shared_name" {
#   source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"
#
#   name          = "vnet-shared-name"
#   value         = azurerm_virtual_network.this.name
#   key_vault_id  = module.kv_shared.id
#
#  tags          = azurerm_resource_group.this.tags
# }
