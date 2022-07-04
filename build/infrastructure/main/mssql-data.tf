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
  mssqlServerAdminName = "gehdbadmin"
}

module "mssql_data" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/mssql-server?ref=7.1.0"

  name                            = "data"
  project_name                    = var.domain_name_short
  environment_short               = var.environment_short
  environment_instance            = var.environment_instance
  sql_version                     = "12.0"
  resource_group_name             = azurerm_resource_group.this.name
  location                        = azurerm_resource_group.this.location

  administrator_login             = local.mssqlServerAdminName
  administrator_login_password    = random_password.mssql_administrator_login_password.result

  # PoC: Try using updated module without changes to see if it is non-breaking.
  # ad_authentication_only          = false

  private_endpoint_subnet_id      = module.snet_private_endpoints.id
  log_analytics_workspace_id      = module.log_workspace_shared.id

  tags                            = azurerm_resource_group.this.tags
}

resource "random_password" "mssql_administrator_login_password" {
  length = 16
  special = true
  override_special = "_%@"
}

module "kvs_mssql_data_admin_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "mssql-data-admin-user-name"
  value         = local.mssqlServerAdminName
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_mssql_data_admin_password" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "mssql-data-admin-user-password"
  value         = random_password.mssql_administrator_login_password.result
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_mssql_data_url" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "mssql-data-url"
  value         = module.mssql_data.fully_qualified_domain_name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_mssql_data_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=7.0.0"

  name          = "mssql-data-name"
  value         = module.mssql_data.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}