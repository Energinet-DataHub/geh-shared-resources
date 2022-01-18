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
  sqlServerAdminName = "gehdbadmin"
}

module "sql_data" {
  source                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/sql-server?ref=feature/sql-server-module"

  name                          = "data"
  project_name                  = var.domain_name_short
  environment_short             = var.environment_short
  environment_instance          = var.environment_instance
  sql_version                   = "12.0"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  administrator_login           = local.sqlServerAdminName
  administrator_login_password  = random_password.sql_administrator_login_password.result
  private_endpoint_subnet_id    = azurerm_subnet.this_private_endpoints_subnet.id
  private_dns_zone_name         = azurerm_private_dns_zone.database.name

  tags                          = azurerm_resource_group.this.tags
}

module "kvs_sql_data_admin_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sql-data-admin-user-name"
  value         = local.sqlServerAdminName
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sql_data_admin_password" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sql-data-admin-user-password"
  value         = random_password.sql_administrator_login_password.result
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_sql_data_url" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sql-data-url"
  value         = module.sql_data.fully_qualified_domain_name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

resource "random_password" "sql_administrator_login_password" {
  length = 16
  special = true
  override_special = "_%@"
}

module "kvs_sql_data_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "sql-data-name"
  value         = module.sql_data.name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}