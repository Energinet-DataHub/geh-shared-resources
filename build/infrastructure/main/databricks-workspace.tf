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



resource "null_resource" "databricks_token" {
  triggers = {
    workspace = azurerm_databricks_workspace.dbw_shared.id
  }
  provisioner "local-exec" {
    command = "chmod +x ${path.cwd}/scripts/generate-pat-token.sh; ${path.cwd}/generate-pat-token.sh"
    environment = {
      RESOURCE_GROUP = var.resource_group_name
      DATABRICKS_WORKSPACE_RESOURCE_ID = azurerm_databricks_workspace.dbw_shared.id
      KEY_VAULT = module.kv_shared.name
      SECRET_NAME = "DATABRICKS-TOKEN"
      DATABRICKS_ENDPOINT = "https://${azurerm_databricks_workspace.dbw_shared.location}.azuredatabricks.net"
      # ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID are already 
      # present in the environment if you are using the Terraform
      # extension for Azure DevOps or the starter from 
      # https://github.com/algattik/terraform-azure-pipelines-starter.
      # Otherwise, provide them as additional variables.
    }
  }
}