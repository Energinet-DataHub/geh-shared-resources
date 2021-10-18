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
    data_lake_master_data_blob_name = "masterdata"
    data_lake_events_blob_name      = "events"
    data_lake_results_blob_name     = "results"
    data_lake_snapshots_blob_name   = "snapshots"
    data_lake_timeseries_blob_name  = "timeseries"
    data_lake_data_container_name   = "data"
}

module "st_data_lake" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/storage-account?ref=renetnielsen/3.1.0"

  name                      = "datalake"
  environment_short         = var.environment_short
  environment_instance      = var.environment_instance
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  is_hns_enabled            = true
  containers                = [
    {
      name  = local.data_lake_data_container_name,
    },
  ]

  tags                      = local.tags
}

resource "azurerm_storage_blob" "master_data" {
  name                    = "${local.data_lake_master_data_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = local.data_lake_data_container_name
  type                    = "Block"
}

resource "azurerm_storage_blob" "events" {
  name                    = "${local.data_lake_events_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = local.data_lake_data_container_name
  type                    = "Block"
}

resource "azurerm_storage_blob" "results" {
  name                    = "${local.data_lake_results_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = local.data_lake_data_container_name
  type                    = "Block"
}

resource "azurerm_storage_blob" "snapshots" {
  name                    = "${local.data_lake_snapshots_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = local.data_lake_data_container_name
  type                    = "Block"
}

resource "azurerm_storage_blob" "timeseries" {
  name                    = "${local.data_lake_timeseries_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = local.data_lake_data_container_name
  type                    = "Block"
}

module "kvs_st_data_lake_primary_connection_string" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "${module.st_data_lake.name}-primary-connection-string"
  value         = module.st_data_lake.primary_connection_string
  key_vault_id  = module.kv_shared.id

  tags          = local.tags
}

module "kvs_st_data_lake_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "${module.st_data_lake.name}-name"
  value         = module.st_data_lake.name
  key_vault_id  = module.kv_shared.id

  tags          = local.tags
}

module "kvs_st_data_lake_data_container_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "${module.st_data_lake.name}-data-container-name"
  value         = local.data_lake_data_container_name
  key_vault_id  = module.kv_shared.id

  tags          = local.tags
}

module "kvs_st_data_lake_master_data_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "${module.st_data_lake.name}-masterdata-blob-name"
  value         = local.data_lake_master_data_blob_name
  key_vault_id  = module.kv_shared.id

  tags          = local.tags
}

module "kvs_st_data_lake_events_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "${module.st_data_lake.name}-events-blob-name"
  value         = local.data_lake_events_blob_name
  key_vault_id  = module.kv_shared.id

  tags          = local.tags
}

module "kvs_st_aggregation_data_lake_results_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "${module.st_data_lake.name}-results-blob-name"
  value         = local.data_lake_results_blob_name
  key_vault_id  = module.kv_shared.id

  tags          = local.tags
}

module "kvs_st_aggregation_snapshot_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "${module.st_data_lake.name}-snapshot-blob-name"
  value         = local.data_lake_snapshots_blob_name
  key_vault_id  = module.kv_shared.id

  tags          = local.tags
}

module "kvs_st_data_lake_timeseries_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "${module.st_data_lake.name}-timeseries-blob-name"
  value         = local.data_lake_timeseries_blob_name
  key_vault_id  = module.kv_shared.id

  tags          = local.tags
}