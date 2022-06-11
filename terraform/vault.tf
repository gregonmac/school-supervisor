

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vault" {
  name                        = "${lower(replace(var.mongo_db_atlas.project, " ", "-"))}-vault"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    # key_permissions = [
    #   "Get",
    # ]

    secret_permissions = [
      "Delete", "Get", "List", "Set"
      # "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
    ]

    # storage_permissions = [
    #   "Get",
    # ]
  }
}

