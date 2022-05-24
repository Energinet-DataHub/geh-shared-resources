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

# Queue to forward subscriptions to
module "sbq_market_roles_forwarded" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-queue?ref=6.0.0"

  name                = "market-roles-forwarded"
  namespace_id        = module.sb_domain_relay.id
}

# Add sbq_market_roles_forwarded name to key vault to be able to fetch that out in the market roles repo
module "kvs_market_roles_forwarded_name" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=6.0.0"

  name                = "sbq-market-roles-forward-name"
  value               = module.sbq_market_roles_forwarded.name
  key_vault_id        = module.kv_shared.id

  tags                = azurerm_resource_group.this.tags
}