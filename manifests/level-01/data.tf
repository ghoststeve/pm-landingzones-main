data "azurerm_management_group" "tenant_root_group" {
  display_name = "Tenant Root Group"
}

# data "azurerm_management_group" "vPAW" {
#   depends_on = [module.vpaw]

#   name = "ba-${var.environment_short_name}-mg-vpaw"
# }

data "azurerm_subscriptions" "available" {
}

# data "azurerm_policy_set_definition" "cis_afb" {
#   display_name = "CIS Microsoft Azure Foundations Benchmark v2.0.0"
# }