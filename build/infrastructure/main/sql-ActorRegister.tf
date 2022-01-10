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
  actor_register_database_name = "actorregister"
}

module "sqldb_actor_register" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/sql-database?ref=5.1.0"

  name                  = local.actor_register_database_name
  project_name          = var.domain_name_short
  environment_short     = var.environment_short
  environment_instance  = var.environment_instance
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  server_name           = module.sql_data.name

  tags                  = azurerm_resource_group.this.tags
}

module "kvs_sql_actor_register_database_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.1.0"

  name          = "sql_actor_register_database_name"
  value         = local.actor_register_database_name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}
