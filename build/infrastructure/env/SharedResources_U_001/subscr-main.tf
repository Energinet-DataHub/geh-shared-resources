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
resource "azurerm_role_definition" "dev001_role_definition" {
  name               = "custom-dev001-role-definition"
  scope              = data.azurerm_subscription.this.id

  permissions {
    actions       = ["Microsoft.Storage/storageAccounts/listKeys/action"]
    not_actions   = []  
  }

  assignable_scopes = [
    data.azurerm_subscription.this.id
  ]
}

resource "azurerm_role_assignment" "role_assignment_to_dh_dev_sg" {
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.dev001_role_definition.id
  principal_id       = "ffad55e0-f314-4852-9796-1d094a236e7b"
}