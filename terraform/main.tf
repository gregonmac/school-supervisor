
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    mongodbatlas={
      source="mongodb/mongodbatlas"
      version="1.3.1"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "mongodbatlas" {}