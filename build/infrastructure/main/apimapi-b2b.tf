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
resource "azurerm_api_management_api" "main" {
  name                  = "apimapi-b2b-${var.project}-${var.organisation}-${var.environment}"
  resource_group_name   = data.azurerm_resource_group.main.name
  api_management_name   = azurerm_api_management.main.name
  revision              = "1"
  display_name          = "B2B Api"
  protocols             = ["https"]
  subscription_required = false
}

resource "azurerm_api_management_api_policy" "content_type_policy" {
  api_name            = azurerm_api_management_api.main.name
  resource_group_name = data.azurerm_resource_group.main.name
  api_management_name = azurerm_api_management.main.name

  xml_content = <<XML
    <policies>
      <inbound>
        <base />
        <check-header name="Content-Type" failed-check-httpcode="403" failed-check-error-message="Only Content-Type application/xml is allowed" ignore-case="true">
          <value>application/xml</value>
        </check-header>
      </inbound>
      <backend>
          <base />
      </backend>
      <outbound>
          <base />
      </outbound>
      <on-error>
          <base />
      </on-error>
    </policies>
  XML
}