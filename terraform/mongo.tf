resource "mongodbatlas_project" "main" {
  name   = var.mongo_db_atlas.project
  org_id = var.mongo_db_atlas.organization
}



resource "mongodbatlas_cluster" "main" {
  project_id   = mongodbatlas_project.main.id
  name         = var.mongo_db_atlas.cluster.name
  cluster_type = "REPLICASET"
  provider_region_name = "EUROPE_WEST"
  provider_name = "TENANT"
  backing_provider_name = "AZURE"
  provider_instance_size_name = var.mongo_db_atlas.cluster.type
}