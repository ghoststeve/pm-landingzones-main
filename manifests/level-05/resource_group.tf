module "resource_group" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-resource_group?ref=0.29.7"

  name     = local.service_name_law_rg
  location = var.location

}

module "action_groups_rg" {
  source   = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-resource_group?ref=0.29.7"
  name     = local.service_name_ag_rg
  location = var.location
}
