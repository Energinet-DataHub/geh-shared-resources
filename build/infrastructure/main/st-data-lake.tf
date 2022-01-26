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
    data_lake_timeseries_blob_name  = "timeseries"
    data_lake_data_container_name   = "data"
}

module "st_data_lake" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/storage-account?ref=6.0.0"

  name                            = "datalake"
  project_name                    = var.domain_name_short
  environment_short               = var.environment_short
  environment_instance            = var.environment_instance
  resource_group_name             = azurerm_resource_group.this.name
  location                        = azurerm_resource_group.this.location
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  private_endpoint_subnet_id      = module.snet_internal_private_endpoints.id
  private_dns_resource_group_name = var.landingzone_resource_group_name
  is_hns_enabled                  = true
  containers                      = [
    {
      name  = local.data_lake_data_container_name,
    },
  ]

  tags                            = azurerm_resource_group.this.tags
}

resource "azurerm_storage_blob" "timeseries" {
  name                    = "${local.data_lake_timeseries_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = local.data_lake_data_container_name
  type                    = "Block"
}

module "kvs_st_data_lake_primary_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "st-data-lake-primary-connection-string"
  value         = module.st_data_lake.primary_connection_string
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_st_data_lake_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "st-data-lake-name"
  value         = module.st_data_lake.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_st_data_lake_primary_access_key" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "st-data-lake-primary-access-key"
  value         = module.st_data_lake.primary_access_key
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_st_data_lake_data_container_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "st-data-lake-data-container-name"
  value         = local.data_lake_data_container_name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_st_data_lake_timeseries_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "st-data-lake-timeseries-blob-name"
  value         = local.data_lake_timeseries_blob_name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}