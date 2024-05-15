# Platform Sub Management Group Zones

module "platform_connectivity" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-management_group?ref=0.23.0"

  name                       = "${local.management_group_prefix}-connectivity"
  display_name               = "Connectivity"
  parent_management_group_id = module.platform.id
  subscription_ids           = []
}

module "platform_identity" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-management_group?ref=0.23.0"

  name                       = "${local.management_group_prefix}-identity"
  display_name               = "Identity"
  parent_management_group_id = module.platform.id
  subscription_ids           = [local.pm_identity_sub.subscription_id]
}

module "platform_management" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-management_group?ref=0.23.0"

  name                       = "${local.management_group_prefix}-management"
  display_name               = "Management"
  parent_management_group_id = module.platform.id
  subscription_ids           = [local.pm_management_sub.subscription_id]
}
