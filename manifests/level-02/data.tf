data "azurerm_management_group" "vPAW" {
  name = "ba-${var.environment_short_name}-mg-vpaw"
}

data "azurerm_policy_set_definition" "cis_afb" {
  display_name = "CIS Microsoft Azure Foundations Benchmark v2.0.0"
}