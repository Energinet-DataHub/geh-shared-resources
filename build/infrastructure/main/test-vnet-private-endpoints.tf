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

module "sa_test" {
  source                                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/storage-account?ref=6.0.0"

  name                                      = "vnettest"
  project_name                              = var.domain_name_short
  environment_short                         = var.environment_short
  environment_instance                      = var.environment_instance
  resource_group_name                       = azurerm_resource_group.this.name
  location                                  = azurerm_resource_group.this.location
  account_tier                              = "Standard"
  account_replication_type                  = "GRS"
  private_endpoint_subnet_id                = azurerm_subnet.this_private_endpoints_subnet.id
  private_dns_zone_name                     = azurerm_private_dns_zone.blob.name
  tags                                      = azurerm_resource_group.this.tags
  containers                = [
    {
      name = "input",
      access_type = "private"
    },
  ]
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
  administrator_login           = "derderbestemmer"
  administrator_login_password  = "Thisistest2022_%@"
  private_endpoint_subnet_id    = azurerm_subnet.this_private_endpoints_subnet.id
  private_dns_zone_name         = azurerm_private_dns_zone.database.name
  tags                          = azurerm_resource_group.this.tags
}

module "sqldb_test" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/sql-database?ref=6.0.0"

  name                  = "testdatabase"
  project_name          = var.domain_name_short
  environment_short     = var.environment_short
  environment_instance  = var.environment_instance
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  server_name           = module.sql_data.name

  tags                  = azurerm_resource_group.this.tags
}

module "sb_test" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-namespace?ref=feature/service-bus-module"

  name                  = "testservicebus"
  project_name          = var.domain_name_short
  environment_short     = var.environment_short
  environment_instance  = var.environment_instance
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  private_endpoint_subnet_id    = azurerm_subnet.this_private_endpoints_subnet.id
  private_dns_zone_name         = azurerm_private_dns_zone.servicebus.name
  sku                   = "premium"
  capacity              = 1
  auth_rules            = [
    {
      name    = "listen",
      listen  = true
    },
    {
      name    = "send",
      send    = true
    },
  ]

  tags                = azurerm_resource_group.this.tags
}

module "sbq_testq" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-queue?ref=5.1.0"

  name                = "testq"
  namespace_name      = module.sb_test.name
  resource_group_name = azurerm_resource_group.this.name
}
