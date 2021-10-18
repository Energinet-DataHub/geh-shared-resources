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
locals {
  postoffice_reply_container_name = "postoffice-reply"
}

module "st_marketoperator_response" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//storage-account?ref=3.1.0"

  name                      = "stout${lower(var.project)}${lower(var.organisation)}${lower(var.environment)}"
  resource_group_name       = data.azurerm_resource_group.main.name
  location                  = data.azurerm_resource_group.main.location
  account_replication_type  = "LRS"
  access_tier               = "Hot"
  account_tier              = "Standard"
  containers                = [
    {
      name = local.postoffice_reply_container_name,
    },
    {
      name = "timeseries-postoffice-reply",
    },
    {
      name = "charges-postoffice-reply",
    },
    {
      name = "marketroles-postoffice-reply",
    },
    {
      name = "aggregations-postoffice-reply",
    },
    {
      name = "meteringpoints-postoffice-reply",
    },
  ]

  tags                      = data.azurerm_resource_group.main.tags
}

module "kvs_st_marketoperator_response_connection_string" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=3.1.0"
  name                            = "SHARED-RESOURCES-MARKETOPERATOR-RESPONSE-CONNECTION-STRING"
  value                           = module.stor_data_lake.primary_connection_string
  key_vault_id                    = module.kv.id
  tags                            = data.azurerm_resource_group.main.tags
  dependencies = [
    module.kv.dependent_on,
    module.stor_data_lake.dependent_on
  ]
}

module "kvs_st_marketoperator_container_reply_name" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.3.0"
  name                            = "SHARED-RESOURCES-MARKETOPERATOR-CONTAINER-REPLY-NAME"
  value                           = module.container_postoffice_reply.name
  key_vault_id                    = module.kv.id
  tags                            = data.azurerm_resource_group.main.tags
  dependencies = [
    module.kv.dependent_on,
  ]
}
