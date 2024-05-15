# Used in the MS Graph API call to set up the Partner Topic
data "azurerm_subscription" "current" {}

# data "archive_file" "ecp_timer_based" {
#   type        = "zip"
#   source_dir  = "${path.module}/function-timer"
#   output_path = "${path.module}/function-timer.zip"
# }

# Used to assign the function managed identity MS Graph permissions
data "azuread_service_principal" "msgraph" {
  display_name = "Microsoft Graph"
}
