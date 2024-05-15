# Storage accounts must be globally unique, but also their names
#  cannot contain special characters or upper case characters.
resource "random_string" "sa_suffix" {
  length  = 16 # Storage Account max name is 24 characters. We use 3 for env and 3 for name. PRs are dynamic, headroom is needed.
  special = false
  upper   = false
}

resource "azurerm_storage_account" "ecp" {
  name                     = "${local.resource_prefix_sa}sa001"
  resource_group_name      = module.rg001.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

# Create an App Service Plan for the function app
resource "azurerm_service_plan" "ecp" {
  name                = "${local.resource_prefix}-ecp-sp-01"
  resource_group_name = module.rg001.resource_group_name
  location            = var.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

# Function app names must be globally unique
resource "random_uuid" "func_suffix" {}

resource "azurerm_windows_function_app" "ecp_timer_function" {
  name                = "${local.resource_prefix}-ecp-fa-01"
  resource_group_name = module.rg001.resource_group_name
  location            = var.location

  storage_account_name       = azurerm_storage_account.ecp.name
  storage_account_access_key = azurerm_storage_account.ecp.primary_access_key
  service_plan_id            = azurerm_service_plan.ecp.id


  zip_deploy_file = "${path.module}/function-timer.zip"

  https_only = true

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "powershell"
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.ecp.instrumentation_key

  }

  identity {
    type = "SystemAssigned"
  }

  site_config {

  } # Redundant compulsory element
}

# The function needs to read Applications and Groups, and assign App Roles.
# We tried Application.Read.All but it seemed insufficient to read Service
#  Principals? So now it has Directory.Read.All...
resource "azuread_app_role_assignment" "app_permissions_timer" {
  for_each = toset([
    "Directory.Read.All",
    "AppRoleAssignment.ReadWrite.All",
    "Application.ReadWrite.All",
  ])

  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids[each.value]
  principal_object_id = azurerm_windows_function_app.ecp_timer_function.identity[0].principal_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}


#AppInsights instance to monitor the function apps

#Setup AppInsights workspace
resource "azurerm_log_analytics_workspace" "ecp" {
  name                = "${local.resource_prefix}-ecp-ws-01"
  location            = var.location
  resource_group_name = module.rg001.resource_group_name
  retention_in_days   = 30
}

resource "azurerm_application_insights" "ecp" {
  name                = "${local.resource_prefix}-ecp-ai-01"
  resource_group_name = module.rg001.resource_group_name
  location            = var.location
  application_type    = "web"
}
