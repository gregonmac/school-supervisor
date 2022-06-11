
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.3.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.3.1"
    }
  }
}

provider "random" {
  # Configuration options
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "mongodbatlas" {}
