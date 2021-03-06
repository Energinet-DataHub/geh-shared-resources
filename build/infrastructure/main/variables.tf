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

variable arm_tenant_id {
  type          = string
  description   = "ID of the Azure tenant where the infrastructure is deployed"
}

variable apim_publisher_email {
  type          = string
  description   = "(Required) The email of publisher/company."
}

variable apim_maintenance_mode {
  type          = bool
  description   = "Determine if API Management is in maintenance mode. In maintenance mode all requests will return 503 Service Unavailable."
  default       = false
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

variable virtual_network_resource_group_name {
  type          = string
  description   = "Name of the resource group where the landing zone virtual network is deployed"
}

variable virtual_network_name {
  type          = string
  description   = "Name of the landing zone virtual network"
}

variable deployment_agents_subnet_name {
  type          = string
  description   = "Name of the subnet hosting the deployment agents."
}

variable apim_address_space {
  type          = string
  description   = "Address space of the APIM subnet"
}

variable private_endpoint_address_space {
  type          = string
  description   = "Address space of the private endpoint subnet"
}

variable vnet_integration_address_space {
  type          = string
  description   = "Address space of the vnet integration subnet"
}

variable vnet_integrations_address_space {
  type          = string
  description   = "Address space of the vnet integrations subnet"
}

variable log_retention_in_days {
  type          = number
  description   = "Number of days logs are retained in log analytics workspace"
  default       = 30
}

variable ag_primary_email_address {
  type          = string
  description   = "Email address of primary action group to which alerts will be routed."
}

variable databricks_vnet_address_space {
  type          = string
  description   = "Address space of the Virtual network where the Databricks Workspace is deployed."
}

variable databricks_private_subnet_address_prefix {
  type          = string
  description   = "The address prefix of the private subnet used by Databricks."
}

variable databricks_public_subnet_address_prefix {
  type          = string
  description   = "The address prefix of the public subnet used by Databricks."
}

variable developers_security_group_object_id {
  type          = string
  description   = "(Optional) The Object ID of the Azure AD security group containing DataHub developers."
  default       = null
}
