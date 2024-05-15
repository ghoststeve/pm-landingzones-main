terraform {
  backend "azurerm" { # This backend is to be used when Azure is hosting the backend terraform state file. Keep commented until pipeline created then can be merged over.- https://developer.hashicorp.com/terraform/language/settings/backends/azurerm
  }
  required_version = "~> 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.41.0" #Latest Version as of writing this code. Keep it set to this to avoid breaking changes in future. The ~> allows patch versions but not major. - https://developer.hashicorp.com/terraform/language/expressions/version-constraints
    }
  }
}
