
resource "azurerm_app_configuration" "configurationStore" {
  name                = "${lower(replace(var.mongo_db_atlas.project, " ", "-"))}-config"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}


resource "azurerm_role_assignment" "configurationStore_dataowner" {
  scope                = azurerm_app_configuration.configurationStore.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}
