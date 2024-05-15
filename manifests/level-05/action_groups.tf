module "action_group" {
  depends_on = [module.action_groups_rg]
  source     = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-action_group?ref=0.30.2"

  resource_group_name = local.service_name_ag_rg

  name       = "${local.resource_prefix}-ag-01"
  short_name = "baalerts"

  email_receivers = [
    {
      name                    = "IDAM"
      email_address           = "ba.idam@ba.com"
      use_common_alert_schema = true
    },
    {
      name                    = "TCS Ops Bridge Leads"
      email_address           = "TCSOpsBridgeLeads@ba.com"
      use_common_alert_schema = true
    },
    {
      name                    = "IAG midranges IP"
      email_address           = "iag-midrangesip@baplc.onmicrosoft.com"
      use_common_alert_schema = true
    },
    {
      name                    = "IT Incident Management"
      email_address           = "it.incidentmanagement@iaggbs.com"
      use_common_alert_schema = true
    }
  ]
}
