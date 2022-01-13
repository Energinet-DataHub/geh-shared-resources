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
locals {
  KV_APIM_PFX_CERT_NAME = "U-002-APIM-PFX-CERT"
}

resource "azurerm_key_vault_certificate" "apim_pfx_certificate" {
  name         = local.KV_APIM_PFX_CERT_NAME
  key_vault_id = module.kv_shared.id

  certificate {
    contents = var.apim_base_64_encoded_pfx_cert
    password = ""
  }
}

resource "azurerm_api_management_custom_domain" "apim_custom_domain" {
  api_management_id = module.apim_shared.id

  proxy {
    host_name     = "api.sandbox.datahub.dk"
    key_vault_id  = azurerm_key_vault_certificate.apim_pfx_certificate.secret_id
  }
}