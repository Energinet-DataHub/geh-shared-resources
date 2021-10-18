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

module "sql_shared" {
  source                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/sql-server?ref=renetnielsen/3.1.0"

  name                          = "shared"
  environment_short             = var.environment_short
  environment_instance          = var.environment_instance
  sql_version                   = "12.0"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  administrator_login           = local.sqlServerAdminName
  administrator_login_password  = random_password.sql_administrator_login_password.result
  firewall_rules                = [
    {
      name              = "fwrule"
      start_ip_address  = "0.0.0.0"
      end_ip_address    = "255.255.255.255"
    }
  ]

  tags                          = local.tags
}

module "kvs_db_admin_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "sql-data-admin-user-name"
  value         = local.sqlServerAdminName
  key_vault_id  = module.kv_shared.id
}

module "kvs_db_admin_password" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name          = "sql-data-admin-user-password"
  value         = random_password.sql_administrator_login_password.result
  key_vault_id  = module.kv_shared.id
}

module "kvs_db_url" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"
  name          = "sql-data-url"
  value         = module.sql_shared.fully_qualified_domain_name
  key_vault_id  = module.kv_shared.id
}

resource "random_password" "sql_administrator_login_password" {
  length = 16
  special = true
  override_special = "_%@"
}