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
    master-data-blob-name = "master-data"
    events-blob-name = "events"
    results-blob-name = "results"
    snapshots-blob-name = "snapshots"
    timeseries-blob-name = "timeseries"
}

module "stor_data_lake" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//storage-account?ref=1.7.0"
  name                            = "data${lower(var.project)}${lower(var.organisation)}${lower(var.environment)}"
  resource_group_name             = data.azurerm_resource_group.main.name
  location                        = data.azurerm_resource_group.main.location
  account_replication_type        = "LRS"
  access_tier                     = "Hot"
  account_tier                    = "Standard"
  is_hns_enabled                  = true
  tags                            = data.azurerm_resource_group.main.tags
}

module "stor_data_lake_container" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//storage-container?ref=1.3.0"
  container_name                  = "data-lake"
  storage_account_name            = module.stor_data_lake.name
  container_access_type           = "private"
  dependencies                    = [ module.stor_data_lake.dependent_on ]
}

resource "azurerm_storage_blob" "master_data" {
  name                            = "${local.master-data-blob-name}/"
  storage_account_name            = module.stor_data_lake.name
  storage_container_name          = module.stor_data_lake_container.name
  type                            = "Block"
}

resource "azurerm_storage_blob" "events" {
  name                            = "${local.events-blob-name}/"
  storage_account_name            = module.stor_data_lake.name
  storage_container_name          = module.stor_data_lake_container.name
  type                            = "Block"
}

resource "azurerm_storage_blob" "results" {
  name                            = "${local.results-blob-name}/"
  storage_account_name            = module.stor_data_lake.name
  storage_container_name          = module.stor_data_lake_container.name
  type                            = "Block"
}

resource "azurerm_storage_blob" "snapshots" {
  name                            = "${local.snapshots-blob-name}/"
  storage_account_name            = module.stor_data_lake.name
  storage_container_name          = module.stor_data_lake_container.name
  type                            = "Block"
}

resource "azurerm_storage_blob" "timeseries" {
  name                            = "${local.timeseries-blob-name}/"
  storage_account_name            = module.stor_data_lake.name
  storage_container_name          = module.stor_data_lake_container.name
  type                            = "Block"
}

module "kvs_data_lake_storage_account_key" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.3.0"
  name                            = "DELTA-LAKE-STORAGE-ACCOUNT-KEY"
  value                           = module.stor_data_lake.primary_access_key
  key_vault_id                    = module.kv.id
  tags                            = data.azurerm_resource_group.main.tags
  dependencies = [
    module.kv.dependent_on,
    module.stor_data_lake.dependent_on
  ]
}

module "kvs_data_lake_storage_account_name" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.3.0"
  name                            = "DELTA-LAKE-STORAGE-ACCOUNT-NAME"
  value                           = module.stor_data_lake.name
  key_vault_id                    = module.kv.id
  tags                            = data.azurerm_resource_group.main.tags
  dependencies = [
    module.kv.dependent_on,
    module.stor_data_lake.dependent_on
  ]
}

module "kvs_data_lake_container_name" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.3.0"
  name                            = "DELTA-LAKE-CONTAINER-NAME"
  value                           = module.stor_data_lake_container.name
  key_vault_id                    = module.kv.id
  tags                            = data.azurerm_resource_group.main.tags
  dependencies = [
    module.kv.dependent_on,
    module.stor_data_lake.dependent_on
  ]
}

module "kvs_master_data_blob_name" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.3.0"
  name                            = "DELTA-LAKE-AGGREGATION-MASTER-DATA-BLOB-NAME"
  value                           = local.master-data-blob-name
  key_vault_id                    = module.kv.id
  tags                            = data.azurerm_resource_group.main.tags
  dependencies = [
    module.kv.dependent_on,
    module.stor_data_lake.dependent_on
  ]
}

module "kvs_events_blob_name" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.3.0"
  name                            = "DELTA-LAKE-AGGREGATION-EVENTS-BLOB-NAME"
  value                           = local.events-blob-name
  key_vault_id                    = module.kv.id
  tags                            = data.azurerm_resource_group.main.tags
  dependencies = [
    module.kv.dependent_on,
    module.stor_data_lake.dependent_on
  ]
}

module "kvs_results_blob_name" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.3.0"
  name                            = "DELTA-LAKE-AGGREGATION-RESULTS-BLOB-NAME"
  value                           = local.results-blob-name
  key_vault_id                    = module.kv.id
  tags                            = data.azurerm_resource_group.main.tags
  dependencies = [
    module.kv.dependent_on,
    module.stor_data_lake.dependent_on
  ]
}

module "kvs_snapshots_blob_name" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.3.0"
  name                            = "DELTA-LAKE-AGGREGATION-SNAPSHOTS-BLOB-NAME"
  value                           = local.snapshots-blob-name
  key_vault_id                    = module.kv.id
  tags                            = data.azurerm_resource_group.main.tags
  dependencies = [
    module.kv.dependent_on,
    module.stor_data_lake.dependent_on
  ]
}

module "kvs_timeseries_blob_name" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.3.0"
  name                            = "DELTA-LAKE-TIMESERIES-BLOB-NAME"
  value                           = local.timeseries-blob-name
  key_vault_id                    = module.kv.id
  tags                            = data.azurerm_resource_group.main.tags
  dependencies = [
    module.kv.dependent_on,
    module.stor_data_lake.dependent_on
  ]
}