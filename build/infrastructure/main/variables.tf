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
variable resource_group_name {
  type = string
}

variable "subscription_id" {
  type = string
}

variable environment {
  type          = string
  description   = "Enviroment that the infrastructure code is deployed into"
}

variable project {
  type          = string
  description   = "Project that is running the infrastructure code"
}

variable organisation {
  type          = string
  description   = "Organisation that is running the infrastructure code"
}

variable apim_publisher_email {
  type          = string
  description   = "(Required) The email of publisher/company."
}

variable apimao_metering_point_domain_ingestion_function_url {
  type          = string
  description   = "Url of the Metering Point domain ingestion function, used for configuration inside the API Managment API"
}

variable apimao_metering_point_domain_ingestion_path {
  type          = string
  description   = "Path of the Metering Point domain ingestion function, used for configuration inside the API Managment API"
}

variable apimao_b2b_cim_url_path_suffix {
  type          = string
  description   = "URL path suffix for the b2b cim endpoints, used for configuration inside the API Managment API"
}