# vPaws Sub Management Group Zones

module "vpaws_connectivity_hub" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-management_group?ref=0.23.0"

  name                       = "${local.management_group_prefix}-hub"
  display_name               = "Hub"
  parent_management_group_id = module.vpaw.id
  subscription_ids           = [local.paws_hub_sub.subscription_id]
}

module "vpaw_labs" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-management_group?ref=0.23.0"

  name                       = "${local.management_group_prefix}-labs"
  display_name               = "Labs"
  parent_management_group_id = module.vpaw.id
  subscription_ids           = [local.paws_lab_01a_sub.subscription_id]
}

module "vpaws_shared_services" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-management_group?ref=0.23.0"

  name                       = "${local.management_group_prefix}-sharedservices"
  display_name               = "Shared Services"
  parent_management_group_id = module.vpaw.id
  subscription_ids           = [local.paws_share_services_sub.subscription_id]
}
