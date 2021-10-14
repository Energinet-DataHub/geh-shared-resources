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
    master_data_blob_name = "master-data"
    events_blob_name = "events"
    results_blob_name = "results"
    snapshots_blob_name = "snapshots"
    timeseries_blob_name = "timeseries"
}

module "st_data_lake" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/storage-account?ref=renetnielsen/3.1.0"

  name                      = "data"
  project_name              = var.project
  organisation_name         = var.organisation
  environment_short         = var.environment
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  account_replication_type  = "LRS"
  account_tier              = "Standard"
  is_hns_enabled            = true

  tags                      = azurerm_resource_group.this.tags
}

resource "azurerm_storage_container" "data_lake" {
  name                  = "data-lake"
  storage_account_name  = module.st_data_lake.name
  container_access_type = "private"

  depends_on            = [
    module.st_data_lake.dependent_on,
  ]
}

resource "azurerm_storage_blob" "master_data" {
  name                    = "${local.master_data_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = azurerm_storage_container.data_lake.name
  type                    = "Block"
  
  depends_on              = [
    module.st_data_lake.dependent_on,
    azurerm_storage_container.data_lake,
  ]
}

resource "azurerm_storage_blob" "events" {
  name                    = "${local.events_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = azurerm_storage_container.data_lake.name
  type                    = "Block"
  
  depends_on              = [
    module.st_data_lake.dependent_on,
    azurerm_storage_container.data_lake,
  ]
}

resource "azurerm_storage_blob" "results" {
  name                    = "${local.results_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = azurerm_storage_container.data_lake.name
  type                    = "Block"
  
  depends_on              = [
    module.st_data_lake.dependent_on,
    azurerm_storage_container.data_lake,
  ]
}

resource "azurerm_storage_blob" "snapshots" {
  name                    = "${local.snapshots_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = azurerm_storage_container.data_lake.name
  type                    = "Block"
  
  depends_on              = [
    module.st_data_lake.dependent_on,
    azurerm_storage_container.data_lake,
  ]
}

resource "azurerm_storage_blob" "timeseries" {
  name                    = "${local.timeseries_blob_name}/notused"
  storage_account_name    = module.st_data_lake.name
  storage_container_name  = azurerm_storage_container.data_lake.name
  type                    = "Block"
  
  depends_on              = [
    module.st_data_lake.dependent_on,
    azurerm_storage_container.data_lake,
  ]
}

module "kvs_data_lake_primary_access_key" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "shared-resources--st-data-lake-primary-access-key"
  value         = module.st_data_lake.primary_access_key
  key_vault_id  = module.kv_this.id

  tags          = azurerm_resource_group.this.tags

  dependencies = [
    module.kv_this.dependent_on,
    module.st_data_lake.dependent_on,
  ]
}

module "kvs_st_data_lake_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "shared-resources--st-data-lake-name"
  value         = module.st_data_lake.name
  key_vault_id  = module.kv_this.id

  tags          = azurerm_resource_group.this.tags

  dependencies = [
    module.kv_this.dependent_on,
    module.st_data_lake.dependent_on,
  ]
}

module "kvs_st_data_lake_container_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "shared-resources--st-data-lake-container-name"
  value         = azurerm_storage_container.data_lake.name
  key_vault_id  = module.kv_this.id

  tags          = azurerm_resource_group.this.tags

  dependencies = [
    module.kv_this.dependent_on,
    module.st_data_lake.dependent_on,
  ]
}

module "kvs_st_aggregation_master_data_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "shared-resources--st-aggregation-master-data-blob-name"
  value         = local.master_data_blob_name
  key_vault_id  = module.kv_this.id

  tags          = azurerm_resource_group.this.tags

  dependencies = [
    module.kv_this.dependent_on,
    module.st_data_lake.dependent_on,
  ]
}

module "kvs_st_aggregation_events_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "shared-resources--st-aggregation-events-blob-name"
  value         = local.events_blob_name
  key_vault_id  = module.kv_this.id

  tags          = azurerm_resource_group.this.tags

  dependencies = [
    module.kv_this.dependent_on,
    module.st_data_lake.dependent_on,
  ]
}

module "kvs_st_aggregation_results_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "shared-resources--st-aggregation-results-blob-name"
  value         = local.results_blob_name
  key_vault_id  = module.kv_this.id

  tags          = azurerm_resource_group.this.tags

  dependencies = [
    module.kv_this.dependent_on,
    module.st_data_lake.dependent_on,
  ]
}

module "kvs_st_aggregation_snapshot_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "shared-resources--st-aggregation-snapshot-blob-name"
  value         = local.snapshots_blob_name
  key_vault_id  = module.kv_this.id

  tags          = azurerm_resource_group.this.tags

  dependencies = [
    module.kv_this.dependent_on,
    module.st_data_lake.dependent_on,
  ]
}

module "kvs_st_timeseries_blob_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "shared-resources--st-timeseries-blob-name"
  value         = local.timeseries_blob_name
  key_vault_id  = module.kv_this.id

  tags          = azurerm_resource_group.this.tags

  dependencies = [
    module.kv_this.dependent_on,
    module.st_data_lake.dependent_on,
  ]
}