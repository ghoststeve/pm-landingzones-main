# Landing Zones Management Groups

module "vpaw" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-management_group?ref=0.23.0"

  name                       = "${local.management_group_prefix}-vpaw"
  display_name               = "vPAW"
  parent_management_group_id = module.landing_zones.id
  subscription_ids           = []
}
