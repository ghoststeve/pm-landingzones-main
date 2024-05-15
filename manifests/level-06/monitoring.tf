
//setting up a new action group
module "ecp_action_group" {
  depends_on = [module.rg001] # [module.action_groups_rg]
  source     = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-action_group?ref=0.30.2"

  resource_group_name = module.rg001.resource_group_name

  name       = "${local.resource_prefix}-ecp-ag-01"
  short_name = "ecpalerts"

  email_receivers = [
    {
      name          = "Stuart Jones"
      email_address = "stuart.1.jones@ba.com"
    }
  ]
}

//new alert rule using azurerm_monitor_scheduled_query_rules_alert_v2 resource
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "monitor_failures_rule" {
  name                 = "${var.environment_short_name} - Log Alert - Monitor Failed Runs of Function Apps"
  resource_group_name  = module.rg001.resource_group_name
  location             = var.location
  description          = "Monitors all function apps for failures and alerts if any are found."
  severity             = 1
  enabled              = true
  evaluation_frequency = "PT5M"
  window_duration      = "PT10M"
  scopes               = [azurerm_application_insights.ecp.id]

  criteria {
    query = <<-query

        requests
        | where success == false
        | summarize failedCount=sum(itemCount), impactedUsers=dcount(user_Id) by operation_Name
        | order by failedCount desc

    query

    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0

  }

  action {
    action_groups = [module.ecp_action_group.id]
  }
}

//new alert rule using azurerm_monitor_scheduled_query_rules_alert_v2 resource
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "monitor_errors_rule" {
  name                 = "${var.environment_short_name} - Log Alert - Monitor Error messages from Function Apps"
  resource_group_name  = module.rg001.resource_group_name
  location             = var.location
  description          = "Monitors all function apps for error messages and alerts if any are found."
  severity             = 2
  enabled              = true
  evaluation_frequency = "PT5M"
  window_duration      = "PT10M"
  scopes               = [azurerm_application_insights.ecp.id]

  //Added filtering to remove some of the noise from the logs. Messages contain "error" but contain text like "Error=0" for example from these processes
  criteria {
    query = <<-query

        traces  
        | where message contains "Error"
        | where not(customDimensions.Category contains "Microsoft.Azure.WebJobs.Hosting.OptionsLoggingService")
        | where not(customDimensions.Category contains "Host.Startup")
        | project timestamp,message,operation_Name


    query

    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0

  }

  action {
    action_groups = [module.ecp_action_group.id]
  }
}
