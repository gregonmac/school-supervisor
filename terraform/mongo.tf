resource "mongodbatlas_project" "main" {
  name   = var.mongo_db_atlas.project
  org_id = var.mongo_db_atlas.organization
}



resource "mongodbatlas_cluster" "main" {
  project_id                  = mongodbatlas_project.main.id
  name                        = var.mongo_db_atlas.cluster.name
  cluster_type                = "REPLICASET"
  provider_region_name        = "EUROPE_WEST"
  provider_name               = "TENANT"
  backing_provider_name       = "AZURE"
  provider_instance_size_name = var.mongo_db_atlas.cluster.type
}

resource "random_password" "password" {
  length           = 16
  min_numeric      = 3
  min_upper        = 2
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}



resource "azurerm_key_vault_secret" "mongo_user" {
  name         = "mongo-user"
  value        = "main-user"
  key_vault_id = azurerm_key_vault.vault.id
}
resource "azurerm_key_vault_secret" "mongo_credential" {
  name         = "mongo-credential"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.vault.id
}

resource "azurerm_app_configuration_key" "cluster-connection-string" {
  configuration_store_id = azurerm_app_configuration.configurationStore.id
  key                    = "cluster-connection-string"
  label                  = "mongo"
  value                  = mongodbatlas_cluster.main.connection_strings[0].standard_srv
}

output "cluster" {
  value = mongodbatlas_cluster.main.connection_strings
}

resource "mongodbatlas_database_user" "main" {
  username           = azurerm_key_vault_secret.mongo_user.value
  password           = azurerm_key_vault_secret.mongo_credential.value
  project_id         = mongodbatlas_project.main.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "dbforApp"
  }

  roles {
    role_name     = "readAnyDatabase"
    database_name = "admin"
  }

  labels {
    key   = "My Key"
    value = "My Value"
  }

  scopes {
    name = mongodbatlas_cluster.main.name
    type = "CLUSTER"
  }
}
