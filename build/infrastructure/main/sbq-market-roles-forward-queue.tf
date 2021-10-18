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
module "sbq_market_roles_forwarded_queue" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-queue?ref=renetnielsen/3.1.0"

  name                = "market-roles-forwarded-queue"
  namespace_name      = module.sb_communication.name
  resource_group_name = azurerm_resource_group.this.name

  dependencies        = [
    module.sb_communication.dependent_on,
  ]
}

# Add sbq_market_roles_forwarded_queue name to key vault to be able to fetch that out in the market roles repo
module "kvs_market_roles_forwarded_queue_name" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=renetnielsen/3.1.0"

  name                = "shared-resource--market-roles-forward-queue-name"
  value               = module.sbq_market_roles_forwarded_queue.name
  key_vault_id        = module.kv_this.id

  tags                = azurerm_resource_group.this.tags

  dependencies        = [
    module.kv_this.dependent_on,
    module.sbq_market_roles_forwarded_queue.dependent_on,
  ]
}