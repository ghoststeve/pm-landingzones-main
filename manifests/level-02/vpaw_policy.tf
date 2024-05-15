module "cis_policy_set" {
  source           = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-policy/set_assignment?ref=0.27.1"
  assignment_scope = data.azurerm_management_group.vPAW.id
  assignment_name  = data.azurerm_policy_set_definition.cis_afb.display_name
  initiative_id    = data.azurerm_policy_set_definition.cis_afb.id
  assignment_parameters = {
    maximumDaysToRotate-d8cf8476-a2ec-4916-896e-992351803c44 = 90
  }
}
