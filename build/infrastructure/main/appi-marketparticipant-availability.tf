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
resource "azurerm_application_insights_web_test" "markpart_availability" {
  name                    = "markpart-availability"
  location                = azurerm_resource_group.this.location
  resource_group_name     = azurerm_resource_group.this.name
  application_insights_id = module.appi_shared.id
  kind                    = "ping"
  frequency               = 300
  timeout                 = 60
  enabled                 = true
  geo_locations           = ["emea-nl-ams-azr"]
  configuration           = <<XML
<WebTest Name="markpart-availability" Id="ef2e3b37-738f-4e24-8062-4ff020c6a803" Enabled="True" Timeout="120" xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" PreAuthenticate="True" Proxy="default" StopOnError="False">
	<Items>
		<Request Method="GET" Guid="a1469715-d63e-0a42-5ee6-fe852bf585ae" Version="1.1" Url="https://func-organization-markpart-${var.environment_short}-${var.environment_instance}.azurewebsites.net/api/HealthFunction?" ThinkTime="0" Timeout="120" ParseDependentRequests="False" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" />
	</Items>
</WebTest>
XML

}
