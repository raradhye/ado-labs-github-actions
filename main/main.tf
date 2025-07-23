##################################################################################
# LOCALS
##################################################################################


locals {
  resource_group_name   = "${var.naming_prefix}-${random_integer.name_suffix.result}"
  app_service_plan_name = "${var.naming_prefix}-${random_integer.name_suffix.result}"
  app_service_name      = "${var.naming_prefix}-${random_integer.name_suffix.result}"
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
}

resource "azurerm_app_service" "app_service" {
  name                = local.app_service_name
  location            = azurerm_resource_group.app_service.location
  resource_group_name = azurerm_resource_group.app_service.name
  app_service_plan_id = azurerm_service_plan.app_service.id

  source_control {
    repo_url           = "https://github.com/ned1313/nodejs-docs-hello-world"
    branch             = "main"
    manual_integration = true
    use_mercurial      = false
  }
}
