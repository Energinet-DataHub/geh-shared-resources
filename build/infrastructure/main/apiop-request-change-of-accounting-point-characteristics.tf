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
resource "azurerm_api_management_api_operation" "request_change_of_accounting_point_characteristics" {
  operation_id        = "request-change-of-accounting-point-characteristics"
  api_name            = azurerm_api_management_api.main.name
  resource_group_name = data.azurerm_resource_group.main.name
  api_management_name = azurerm_api_management.main.name
  display_name        = "Request change of accounting point characteristics"
  method              = "POST"
  url_template        = "${var.apim_b2b_cim_url_path_suffix}/request-change-of-accounting-point-characteristics"
}

resource "azurerm_api_management_api_operation_policy" "request_change_of_accounting_point_characteristics_policy" {
  api_name            = azurerm_api_management_api.main.name
  resource_group_name = data.azurerm_resource_group.main.name
  api_management_name = azurerm_api_management.main.name
  operation_id        = azurerm_api_management_api_operation.request_change_of_accounting_point_characteristics.operation_id

  xml_content = <<XML
    <policies>
      <inbound>
        <base />
        <set-backend-service backend-id="${var.metering_point_domain_ingestion_function_name}" />
        <rewrite-uri template="${var.metering_point_domain_ingestion_path}" />
      </inbound>
    </policies>
  XML
}