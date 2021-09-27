resource "azurerm_api_management_api" "main" {
  name                = "apimapi-b2b-${var.project}-${var.organisation}-${var.environment}"
  resource_group_name = data.azurerm_resource_group.main.name
  api_management_name = azurerm_api_management.main.name
  revision            = "1"
  display_name        = "B2B Api"
  protocols           = ["https"]
}