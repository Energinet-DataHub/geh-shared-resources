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
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/api-management-api?ref=4.1.0"

  name                  = "b2b"
  environment_short     = var.environment_short
  environment_instance  = var.environment_instance
  api_management_name   = module.apim_shared.name
  resource_group_name   = azurerm_resource_group.this.name
  revision              = "1"
  display_name          = "B2B Api"
  protocols             = ["https"]
  subscription_required = false
  policies              = [
    {
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
  ]
}