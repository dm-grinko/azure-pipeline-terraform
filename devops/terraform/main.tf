terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {
  name = "${var.prefix}-${random_id.seed.hex}"
}

resource "random_id" "seed" {
  byte_length = 4
}

resource "azurerm_resource_group" "test_rg" {
  name     = local.name
  location = var.region
}
