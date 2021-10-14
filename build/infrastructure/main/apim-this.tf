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
module "apim_this" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management?ref=renetnielsen/3.1.0"

  name                = "main"
  project_name        = var.project
  organisation_name   = var.organisation
  environment_short   = var.environment
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  publisher_name      = var.organisation
  publisher_email     = var.apim_publisher_email
  sku_name            = "Developer_1"

  tags                = azurerm_resource_group.this.tags
}