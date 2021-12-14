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
module "apima_b2b" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management-api?ref=5.2.0"

  name                      = "b2b"
  project_name              = var.domain_name_short
  environment_short         = var.environment_short
  environment_instance      = var.environment_instance
  api_management_name       = module.apim_shared.name
  resource_group_name       = azurerm_resource_group.this.name
  revision                  = "1"
  display_name              = "B2B Api"
  protocols                 = ["https"]
  subscription_required     = false
  authorization_server_name = azurerm_api_management_authorization_server.oauth_server.name
  policies                  = [
    {
      xml_content = <<XML
        <policies>
          <inbound>
            <base />
            <choose>
                <when condition="@(context.Request.Method == "POST")">
                    <set-variable name="bodySize" value="@(context.Request.Headers["Content-Length"][0])" />
                    <choose>
                        <when condition="@(int.Parse(context.Variables.GetValueOrDefault<string>("bodySize"))<52428800)">
                            <!--let it pass through by doing nothing-->
                        </when>
                        <otherwise>
                            <return-response>
                                <set-status code="413" reason="Payload Too Large" />
                                <set-body>@{
                                        return "Maximum allowed size for the POST requests is 52428800 bytes (50 MB). This request has size of "+ context.Variables.GetValueOrDefault<string>("bodySize") +" bytes";
                                    }</set-body>
                            </return-response>
                        </otherwise>
                    </choose>
                </when>
            </choose>
            <check-header name="Content-Type" failed-check-httpcode="415" failed-check-error-message="Only Content-Type application/xml is allowed" ignore-case="true">
              <value>application/xml</value>
            </check-header>
            <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized. Failed policy requirements, or token is invalid or missing.">
                <openid-config url="https://login.microsoftonline.com/${var.apim_b2c_tenant_id}/v2.0/.well-known/openid-configuration" />
                <required-claims>
                    <claim name="aud" match="any">
                        <value>${var.backend_service_app_id}</value>
                    </claim>
                </required-claims>
            </validate-jwt>
            <set-header name="Correlation-ID" exists-action="override">
                <value>@($"{context.RequestId}")</value>
            </set-header>
            <set-header name="RequestTime" exists-action="override">
                <value>@(DateTime.UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ"))</value>
            </set-header>
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
  ]
}