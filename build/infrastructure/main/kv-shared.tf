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
module "kv_shared" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault?ref=feature/key-vault-module"

  name                            = "main"
  project_name                    = var.domain_name_short
  environment_short               = var.environment_short
  environment_instance            = var.environment_instance
  resource_group_name             = azurerm_resource_group.this.name
  location                        = azurerm_resource_group.this.location
  enabled_for_template_deployment = true
  sku_name                        = "premium"
  private_endpoint_subnet_id      = azurerm_subnet.this_private_endpoints_subnet.id
  private_dns_zone_name           = azurerm_private_dns_zone.keyvault.name

  tags                            = azurerm_resource_group.this.tags
}
