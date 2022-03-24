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

module "ag_primary" {
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/monitor-action-group-email?ref=5.8.0"

  name                      = "primary"
  project_name              = var.domain_name_short
  environment_short         = var.environment_short
  environment_instance      = var.environment_instance
  resource_group_name       = azurerm_resource_group.this.name

  short_name                = "Primary"
  email_receiver_name       = "DevOps"
  email_receiver_address    = var.ag_primary_email_address

  tags                      = azurerm_resource_group.this.tags
}

module "kvs_ag_primary_id" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.8.0"

  name          = "ag-primary-id"
  value         = module.ag_primary.id
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}