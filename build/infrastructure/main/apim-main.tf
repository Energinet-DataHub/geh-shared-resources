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
# module "snet_apim" {
#   source                                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/subnet?ref=6.0.0"
#   name                                          = "apim"
#   project_name                                  = var.domain_name_short
#   environment_short                             = var.environment_short
#   environment_instance                          = var.environment_instance
#   resource_group_name                           = azurerm_resource_group.this.name
#   virtual_network_name                          = module.vnet_main.name
#   address_prefixes                              = ["10.42.0.0/29"]
# }

# module "apim_shared" {
#   source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management?ref=6.0.0"

#   name                  = "main"
#   project_name          = var.domain_name_short
#   environment_short     = var.environment_short
#   environment_instance  = var.environment_instance
#   resource_group_name   = azurerm_resource_group.this.name
#   location              = azurerm_resource_group.this.location
#   publisher_name        = var.project_name
#   publisher_email       = var.apim_publisher_email
#   sku_name              = "Developer_1"
#   virtual_network_type  = "External"
#   subnet_id             = module.snet_apim.id

#   tags                  = azurerm_resource_group.this.tags
# }

# resource "azurerm_api_management_authorization_server" "oauth_server" {
#   name                         = "oauthserver"
#   api_management_name          = module.apim_shared.name
#   resource_group_name          = azurerm_resource_group.this.name
#   display_name                 = "OAuth client credentials server"
#   client_registration_endpoint = "http://localhost/"
#   grant_types = [
#     "clientCredentials",
#   ]
#   authorization_endpoint       = "https://login.microsoftonline.com/${var.apim_b2c_tenant_id}/oauth2/v2.0/authorize"
#   authorization_methods        =  [
#     "GET",
#   ]
#   token_endpoint               = "https://login.microsoftonline.com/${var.apim_b2c_tenant_id}/oauth2/v2.0/token"
#   client_authentication_method = [
#     "Body",
#   ]
#   bearer_token_sending_methods = [
#     "authorizationHeader",
#   ]
#   default_scope                = "api://${var.backend_service_app_id}/.default"
#   client_id                    = var.backend_service_app_id
# }

# resource "azurerm_api_management_logger" "apim_logger" {
#   name                = "apim-logger"
#   api_management_name = module.apim_shared.name
#   resource_group_name = azurerm_resource_group.this.name
#   resource_id         = module.appi_shared.id

#   application_insights {
#     instrumentation_key = module.appi_shared.instrumentation_key
#   }
# }

module "kvs_b2c_tenant_id" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.1.0"

  name          = "b2c-tenant-id"
  value         = var.apim_b2c_tenant_id
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_backend_service_app_id" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.1.0"

  name          = "backend-service-app-id"
  value         = var.backend_service_app_id
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}
