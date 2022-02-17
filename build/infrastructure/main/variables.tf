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
variable subscription_id {
  type        = string
  description = "Subscription that the infrastructure code is deployed into."
}

variable resource_group_name {
  type        = string
  description = "Resource Group that the infrastructure code is deployed into."
}

variable environment_short {
  type          = string
  description   = "Enviroment that the infrastructure code is deployed into."
}

variable environment_instance {
  type          = string
  description   = "Enviroment instance that the infrastructure code is deployed into."
}

variable domain_name_short {
  type          = string
  description   = "Shortest possible edition of the domain name."
}

variable project_name {
  type          = string
}

variable apim_publisher_email {
  type          = string
  description   = "(Required) The email of publisher/company."
}

variable apimao_charges_domain_ingestion_function_url {
  type          = string
  description   = "Url of the Charges domain ingestion function, used for configuration inside the API Managment API."
}

variable apimao_market_roles_domain_ingestion_function_url {
  type          = string
  description   = "Url of the Market Roles domain ingestion function, used for configuration inside the API Managment API."
}

variable apimao_messagehub_domain_ingestion_function_url {
  type          = string
  description   = "Url of the Message hub domain ingestion function, used for configuration inside the API Managment API."
}

variable apimao_metering_point_domain_ingestion_function_url {
  type          = string
  description   = "Url of the Metering Point domain ingestion function, used for configuration inside the API Managment API."
}

variable apimao_timeseries_domain_ingestion_function_url {
  type          = string
  description   = "Url of the Timeseries domain ingestion function, used for configuration inside the API Managment API."
}

variable apim_b2c_tenant_id {
  type          = string
  description   = "ID of the B2C tenant hosting the backend app registrations authorizing against."
}

variable backend_service_app_id {
  type          = string
  description   = "The app/client ID of the backend app registration."
}

variable frontend_open_id_url {
  type          = string
  description   = "Open ID configuration URL used for authtication of the frontend."
}

variable frontend_service_app_id {
  type          = string
  description   = "The app/client ID of the frontend app registration."
}

variable private_dns_resource_group_name {
  type          = string
  description   = "Name of the resource group where the private DNS zones are deployed"
}

variable private_dns_zone_blob_name {
  type        = string
  description = "Name of the Storage Account blob private DNS zone"
}

variable private_dns_zone_file_name {
  type        = string
  description = "Name of the Storage Account file private DNS zone"
}

variable private_dns_zone_keyvault_name {
  type        = string
  description = "Name of the Key Vault private DNS zone"
}

variable private_dns_zone_database_name {
  type        = string
  description = "Name of the SQL database private DNS zone"
}

variable private_dns_zone_servicebus_name {
  type        = string
  description = "Name of the Service Bus private DNS zone"
}

variable private_dns_zone_cosmos_name {
  type        = string
  description = "Name of the Cosmos SQL database private DNS zone"
}

variable private_dns_zone_azurewebsites_name {
  type        = string
  description = "Name of the Azure websites private DNS zone"
}

variable landing_zone_resource_group_name {
  type          = string
  description   = "Resource group name of the landing zone network"
}

variable virtual_network_resource_group_name {
  type          = string
  description   = "Name of the resource group where the landing zone virtual network is deployed"
}

variable virtual_network_name {
  type          = string
  description   = "Name of the landing zone virtual network"
}

variable internal_virtual_network_address_space {
  type          = string
  description   = "Address space of the internal virtual network"
}

variable apim_address_space {
  type          = string
  description   = "Address space of the APIM subnet"
}

variable log_retention_in_days {
  type          = number
  description   = "Number of days logs are retained in log analytics workspace"
  default       = 30
}
