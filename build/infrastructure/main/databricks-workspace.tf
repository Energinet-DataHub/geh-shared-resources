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
data "azurerm_client_config" "this" {}

resource "azurerm_databricks_workspace" "dbw_shared" {
  name                = "dbw-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "standard"

  tags                = azurerm_resource_group.this.tags
}

module "kvs_databricks_workspace_id" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.1.0"

  name          = "dbw-shared-workspace-id"
  value         = azurerm_databricks_workspace.dbw_shared.workspace_id
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_databricks_workspace_url" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=5.1.0"

  name          = "dbw-shared-workspace-url"
  value         = azurerm_databricks_workspace.dbw_shared.workspace_url
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = module.kv_shared.id

  tenant_id = data.azurerm_client_config.this.tenant_id
  object_id = data.azurerm_client_config.this.object_id

  secret_permissions = [
    "set",
  ]
}

resource "null_resource" "databricks_token" {
  triggers = {
    workspace = azurerm_databricks_workspace.dbw_shared.id
    key_vault_access = azurerm_key_vault_access_policy.this.id
  }
  provisioner "local-exec" {
    command = "${path.module}/scripts/generate-pat-token.sh"
    environment = {
      RESOURCE_GROUP = var.resource_group_name
      DATABRICKS_WORKSPACE_RESOURCE_ID = azurerm_databricks_workspace.databricks.id
      KEY_VAULT = azurerm_key_vault.databricks_token.name
      SECRET_NAME = "DATABRICKS-TOKEN"
      DATABRICKS_ENDPOINT = "https://${data.azurerm_resources.databricks.resources[0].location}.azuredatabricks.net"
      # ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID are already 
      # present in the environment if you are using the Terraform
      # extension for Azure DevOps or the starter from 
      # https://github.com/algattik/terraform-azure-pipelines-starter.
      # Otherwise, provide them as additional variables.
    }
  }
}