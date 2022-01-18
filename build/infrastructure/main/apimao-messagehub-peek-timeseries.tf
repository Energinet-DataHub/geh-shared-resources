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
module "apimao_messagehub_peek_timeseries" {
  source                  = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management-api-operation?ref=5.1.0"

  operation_id            = "peek-timeseries"
  api_management_api_name = module.apima_b2b.name
  resource_group_name     = azurerm_resource_group.this.name
  api_management_name     = module.apim_shared.name
  display_name            = "Message Hub: Peek timeseries"
  method                  = "GET"
  url_template            = "/v1.0/cim/timeseries/{id}"
  template_parameters     = [
    {
      name      = "id"
      required  = true
      type      = "string"
    }
  ]
  policies                = [
    {
      xml_content = <<XML
        <policies>
          <inbound>
            <base />
            <validate-jwt header-name="Authorization" failed-validation-httpcode="403" failed-validation-error-message="Unauthorized to access this endpoint.">
                <openid-config url="https://login.microsoftonline.com/${var.apim_b2c_tenant_id}/v2.0/.well-known/openid-configuration" />
                <required-claims>
                    <claim name="roles" match="any">
                        <value>meterdataresponsible</value>
                        <value>balanceresponsibleparty</value>
                        <value>gridoperator</value>
                        <value>electricalsupplier</value>
                        <value>transmissionsystemoperator</value>
                    </claim>
                </required-claims>
            </validate-jwt>
            <set-backend-service backend-id="${azurerm_api_management_backend.messagehub.name}" />
            <rewrite-uri template="/api/peek/timeseries" />
            <set-query-parameter name="bundleid" exists-action="override">
              <value>@(context.Request.MatchedParameters["id"])</value>
            </set-query-parameter>
          </inbound>
        </policies>
      XML
    }
  ]
}
