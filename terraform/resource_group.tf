
resource "azurerm_resource_group" "rg" {
  name     = var.azure.rg_name
  location = var.azure.location
}
