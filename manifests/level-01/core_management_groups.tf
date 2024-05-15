# Environment Management Group

module "environment" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-management_group?ref=0.23.0"

  name                       = "${local.management_group_prefix}-${var.environment}"
  display_name               = title(var.environment)
  parent_management_group_id = data.azurerm_management_group.tenant_root_group.id
  subscription_ids           = []
}

# Core Management Groups

module "platform" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-management_group?ref=0.23.0"

  name                       = "${local.management_group_prefix}-platform"
  display_name               = "Platform"
  parent_management_group_id = module.environment.id
  subscription_ids           = []
}

module "landing_zones" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-management_group?ref=0.23.0"

  name                       = "${local.management_group_prefix}-landingzones"
  display_name               = "Landing Zones"
  parent_management_group_id = module.environment.id
  subscription_ids           = []
}
