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
output private_dns_zone_blob_name {
  description = "Name of the blob private dns zone"
  value       = azurerm_private_dns_zone.blob.name
}

output private_dns_zone_file_name {
  description = "Name of the Storage Account file private dns zone"
  value       = azurerm_private_dns_zone.file.name
}

output private_dns_zone_keyvault_name {
  description = "Name of the Key Vault private dns zone"
  value       = azurerm_private_dns_zone.keyvault.name
}

output private_dns_zone_database_name {
  description = "Name of the SQL database private dns zone"
  value       = azurerm_private_dns_zone.database.name
}

output private_dns_zone_servicebus_name {
  description = "Name of the Service Bus private dns zone"
  value       = azurerm_private_dns_zone.servicebus.name
}

output private_dns_zone_cosmos_name {
  description = "Name of the Cosmos SQL database private dns zone"
  value       = azurerm_private_dns_zone.cosmos.name
}

output private_dns_zone_azurewebsites_name {
  description = "Name of the Azure websites private dns zone"
  value       = azurerm_private_dns_zone.azurewebsites.name
}