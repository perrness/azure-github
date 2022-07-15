terraform {
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.14.0"
    }
    github = {
      source  = "integrations/github"
      version = "4.26.1"
    }
  }
}

provider "azurerm" {
  use_oidc = true
  features {}
}

provider "github" {
  token = GITHUB_TOKEN
}
