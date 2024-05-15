module "storage_account" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-storage_account?ref=0.22.0"

  depends_on = [module.resource_group]

  name                     = "${local.resource_prefix_sa}sa01"
  resource_group_name      = local.service_name_law_rg
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

module "log_analytics_workspace" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-log_analytics_workspace?ref=0.22.0"

  depends_on = [module.storage_account]

  name                = "${local.resource_prefix}-law-ws-01"
  location            = var.location
  resource_group_name = local.service_name_law_rg
  sku                 = "PerGB2018"

}

resource "azurerm_log_analytics_linked_storage_account" "mgmt_law" {

  depends_on = [module.log_analytics_workspace]

  data_source_type      = "CustomLogs"
  resource_group_name   = local.service_name_law_rg
  workspace_resource_id = module.log_analytics_workspace.id
  storage_account_ids   = [module.storage_account.id]
}
