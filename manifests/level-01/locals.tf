locals {

  management_group_prefix = "ba-${var.environment_short_name}-mg"

  subscription_prefix_pm   = "BritishAirways-${var.environment_short_name}-pm"
  subscription_prefix_paws = "BritishAirways-${var.environment_short_name}-vpaw"

  pm_management_sub = data.azurerm_subscriptions.available.subscriptions[index(data.azurerm_subscriptions.available.subscriptions.*.display_name, "${local.subscription_prefix_pm}-mgmt")]
  pm_identity_sub   = data.azurerm_subscriptions.available.subscriptions[index(data.azurerm_subscriptions.available.subscriptions.*.display_name, "${local.subscription_prefix_pm}-identity")]
  # # pm_connectivity_sub = data.azurerm_subscriptions.available.subscriptions[index(data.azurerm_subscriptions.available.subscriptions.*.display_name, "${local.subscription_prefix_pm}-Connectivity")]

  paws_hub_sub            = data.azurerm_subscriptions.available.subscriptions[index(data.azurerm_subscriptions.available.subscriptions.*.display_name, "${local.subscription_prefix_paws}-hub")]
  paws_share_services_sub = data.azurerm_subscriptions.available.subscriptions[index(data.azurerm_subscriptions.available.subscriptions.*.display_name, "${local.subscription_prefix_paws}-sharedservices")]
  paws_lab_01a_sub        = data.azurerm_subscriptions.available.subscriptions[index(data.azurerm_subscriptions.available.subscriptions.*.display_name, "${local.subscription_prefix_paws}-lab-01a")]
  # ${local.subscription_prefix_paws}-lab-01a for the above when provisioned.

}
