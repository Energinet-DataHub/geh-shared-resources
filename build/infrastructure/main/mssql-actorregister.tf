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
  ms_actor_register_database_name = "msactorregister"
}

module "mssqldb_actor_register" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/mssql-database?ref=5.4.0"

  name                  = local.ms_actor_register_database_name
  project_name          = var.domain_name_short
  environment_short     = var.environment_short
  environment_instance  = var.environment_instance
  server_id             = module.mssql_data.id

  tags                  = azurerm_resource_group.this.tags
}

module "kvs_sql_ms_actor_register_database_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.1.0"

  name          = "mssql-actor-register-database-name"
  value         = module.mssqldb_actor_register.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}