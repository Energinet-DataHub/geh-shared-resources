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
variable utils_subscription_id {
  type        = string
  description = "ID of the subscription where the Utils key vault is deployed."
}

variable utils_keyvault_name {
  type        = string
  description = "The name of the utilities key vault."
}

variable utils_resource_group_name {
  type        = string
  description = "Resource Group where the utilities key vault is deployed into."
}