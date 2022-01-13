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
module "plan_shared" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/app-service-plan?ref=6.0.0"

  name                  = "test"
  project_name          = var.domain_name_short
  environment_short     = var.environment_short
  environment_instance  = var.environment_instance
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  kind                  = "FunctionApp"
  sku                   = {
    tier  = "Premium"
    size  = "P1V2"
  }

  tags                = azurerm_resource_group.this.tags
}

module "func_test" {
  source                                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/function-app?ref=6.0.0"

  name                                      = "test"
  project_name                              = var.domain_name_short
  environment_short                         = var.environment_short
  environment_instance                      = var.environment_instance
  resource_group_name                       = azurerm_resource_group.this.name
  location                                  = azurerm_resource_group.this.location
  app_service_plan_id                       = module.plan_shared.id
  application_insights_instrumentation_key  = module.appi_shared.instrumentation_key
  always_on                                 = true
  vnet_integration_subnet_id                = azurerm_subnet.this_vnet_integrations.id
  private_endpoint_subnet_id                = azurerm_subnet.this_private_endpoints_subnet.id
  private_dns_zone_name                     = azurerm_private_dns_zone.blob.name
  app_settings                              = {
    # Region: Default Values
    WEBSITE_ENABLE_SYNC_UPDATE_SITE       = true
    WEBSITE_RUN_FROM_PACKAGE              = 1
    WEBSITES_ENABLE_APP_SERVICE_STORAGE   = true
    FUNCTIONS_WORKER_RUNTIME              = "dotnet"
    privatecfm_STORAGE                    = module.sa_test.primary_connection_string
    sqldb_connection                      = "Server=tcp:sql-data-vnettest-x-1.database.windows.net,1433;Initial Catalog=sqldb-testdatabase-vnettest-x-1;Persist Security Info=False;User ID=derderbestemmer;Password=Thisistest2022_%@;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }

  tags                                    = azurerm_resource_group.this.tags
}


