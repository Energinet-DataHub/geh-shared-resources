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
resource "azurerm_portal_dashboard" "my-board" {
  name                  = "CPU utilization and Memory consumption by resource"
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  dashboard_properties  = templatefile("dashboard-templates/cpu_memory_by_resource.tpl",
    {
      subscription_id = "Variable content here!",
      shared_resources_resource_group_name = "rg-DataHub-SharedResouces-U-001",
      shared_plan_name = "plan-shared-sharedres-u-001"
      charges_resource_group_name = "rg-DataHub-Charges-U-001"
    })
  
  tags                         = azurerm_resource_group.this.tags
}