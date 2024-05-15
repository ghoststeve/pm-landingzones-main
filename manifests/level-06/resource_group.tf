module "rg001" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-resource_group?ref=0.14.0"

  name     = local.service_name_rg
  location = var.location
}
