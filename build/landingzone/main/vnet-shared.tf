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

module "vnet_integrations" { 
  source                                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/subnet?ref=6.0.0"
  name                                          = "vnet_integrations"
  project_name                                  = var.project_name
  environment_short                             = var.environment_short
  environment_instance                          = var.environment_instance
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.this.name
  address_prefixes                              = ["10.0.8.0/22"]
  enforce_private_link_service_network_policies = true
  
  # Delegate the subnet to "Microsoft.Web/serverFarms"
  delegations =  [{
   name = "delegation"
   service_delegation_name    = "Microsoft.Web/serverFarms"
   service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
  }]
}

module "private_endpoints_subnet" { 
  source                                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/subnet?ref=6.0.0"
  name                                          = "private_endpoints_subnet"
  project_name                                  = var.project_name
  environment_short                             = var.environment_short
  environment_instance                          = var.environment_instance
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.this.name
  address_prefixes                              = ["10.0.12.0/22"]
  enforce_private_link_endpoint_network_policies  = true
  enforce_private_link_service_network_policies = true
}

module "external_endpoints_subnet" { 
  source                                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/subnet?ref=6.0.0"
  name                                          = "external_endpoints_subnet"
  project_name                                  = var.project_name
  environment_short                             = var.environment_short
  environment_instance                          = var.environment_instance
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.this.name
  address_prefixes                              = ["10.0.16.0/22"]
  enforce_private_link_endpoint_network_policies  = true
}


module "kvs_vnet_shared_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=feature/key-vault-module"

  name          = "vnet-shared-name"
  value         = azurerm_virtual_network.this.name
  key_vault_id  = module.kv_shared.id

 tags          = azurerm_resource_group.this.tags
}


