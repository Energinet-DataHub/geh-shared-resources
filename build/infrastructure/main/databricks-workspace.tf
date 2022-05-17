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
module "dbw_shared" {
  source                                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/databricks-workspace?ref=6.0.0"

  name                                      = "dbw"
  project_name                              = var.domain_name_short
  environment_short                         = var.environment_short
  environment_instance                      = var.environment_instance
  resource_group_name                       = azurerm_resource_group.this.name
  location                                  = azurerm_resource_group.this.location
  sku                                       = "standard"
  main_virtual_network_id                   = data.azurerm_virtual_network.this.id
  main_virtual_network_name                 = data.azurerm_virtual_network.this.name
  main_virtual_network_resource_group_name  = data.azurerm_virtual_network.this.resource_group_name
  databricks_virtual_network_address_space  = var.databricks_vnet_address_space
  private_subnet_address_prefix             = var.databricks_private_subnet_address_prefix
  public_subnet_address_prefix              = var.databricks_public_subnet_address_prefix

  tags                                      = azurerm_resource_group.this.tags
}

module "kvs_databricks_workspace_id" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "dbw-shared-workspace-id"
  value         = module.dbw_shared.id
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_databricks_workspace_url" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "dbw-shared-workspace-url"
  value         = module.dbw_shared.workspace_url
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

module "kvs_databricks_private_dns_resource_group_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name          = "databricks-private-dns-resource-group-name"
  value         = module.dbw_shared.private_dns_zone_resource_group_name
  key_vault_id  = module.kv_shared.id

  tags          = azurerm_resource_group.this.tags
}

resource "null_resource" "databricks_token" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "chmod +x ${path.cwd}/scripts/generate-pat-token.sh; ${path.cwd}/scripts/generate-pat-token.sh"
    environment = {
      DATABRICKS_WORKSPACE_RESOURCE_ID = module.dbw_shared.id
      KEY_VAULT = module.kv_shared.name
      SECRET_NAME = "dbw-shared-workspace-token"
      DATABRICKS_ENDPOINT = "https://${module.dbw_shared.location}.azuredatabricks.net"
      # ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID are already
      # present in the environment if you are using the Terraform
      # extension for Azure DevOps or the starter from
      # https://github.com/algattik/terraform-azure-pipelines-starter.
      # Otherwise, provide them as additional variables.
    }
  }

  depends_on = [
    module.dbw_shared
  ]
}