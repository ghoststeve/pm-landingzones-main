provider "azurerm" { # Provider used to determine where to put your resources in Azure.
  subscription_id = var.subscription_id
  features {}
}
