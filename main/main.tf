##################################################################################
# LOCALS
##################################################################################


locals {
  resource_group_name   = "${var.naming_prefix}-${random_integer.name_suffix.result}"
  app_service_plan_name = "asp-${var.naming_prefix}-${random_integer.name_suffix.result}"
  app_service_name      = "app-${var.naming_prefix}-${random_integer.name_suffix.result}"
}

resource "random_integer" "name_suffix" {
  min = 10000
  max = 99999
}

##################################################################################
# APP SERVICE
##################################################################################

resource "azurerm_resource_group" "app_service" {
  name     = local.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "app_service" {
  name                = local.app_service_plan_name
  location            = azurerm_resource_group.app_service.location
  resource_group_name = azurerm_resource_group.app_service.name
  os_type             = var.os_type
  sku_name            = var.sku_name

  # checkov:skip=CKV_AZURE_212: Resume project - single instance OK for demo
  # checkov:skip=CKV_AZURE_225: Zone redundancy not critical for demo
}

resource "azurerm_windows_web_app" "app_service" {
  name                = local.app_service_name
  resource_group_name = azurerm_resource_group.app_service.name
  location            = azurerm_resource_group.app_service.location
  service_plan_id     = azurerm_service_plan.app_service.id

  site_config {}
  application_stack {
    current_stack = "node"
    node_version  = "18-lts" # You can change this based on your needs
  }
  # checkov:skip=CKV_AZURE_222: Public access is acceptable in this demo
  # checkov:skip=CKV_AZURE_14: HTTPS redirection not needed for demo
  # checkov:skip=CKV_AZURE_213: No health check for Hello World  
}

resource "azurerm_app_service_source_control" "app_source_control" {
  app_id                 = azurerm_windows_web_app.app_service.id
  repo_url               = "https://github.com/raradhye/ado-labs-github-actions"
  branch                 = "main"
  use_manual_integration = true
  use_mercurial          = false
}
