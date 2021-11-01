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
module "apimao_request_change_of_accounting_point_characteristics" {
  source                  = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management-api-operation?ref=5.1.0"

  operation_id            = "request-change-of-accounting-point-characteristics"
  api_management_api_name = module.apima_b2b.name
  resource_group_name     = azurerm_resource_group.this.name
  api_management_name     = module.apim_shared.name
  display_name            = "Request change of accounting point characteristics"
  method                  = "POST"
  url_template            = "${var.apimao_b2b_cim_url_path_suffix}/request-change-of-accounting-point-characteristics"
  policies                = [
    {
      xml_content = <<XML
        <policies>
          <inbound>
            <base />
            <set-backend-service backend-id="${azurerm_api_management_backend.metering_point.name}" />
            <rewrite-uri template="${var.apimao_metering_point_domain_ingestion_path}" />
          </inbound>
        </policies>
      XML
    }
  ]
}
