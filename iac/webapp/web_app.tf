resource "azurerm_service_plan" "service_plan" {
  name                = "${var.rsg_name}-asp-${var.env}"
  resource_group_name = azurerm_resource_group.rsg.name
  location            = azurerm_resource_group.rsg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "linux_web_app" {
  name                = "${var.rsg_name}-lwa-${var.env}"
  resource_group_name = azurerm_resource_group.rsg.name
  location            = azurerm_service_plan.service_plan.location
  service_plan_id     = azurerm_service_plan.service_plan.id
  site_config {
    application_stack {
      docker_image_name        = "${data.azurerm_container_registry.acr.login_server}/abb-python:latest"
      docker_registry_url      = data.azurerm_container_registry.acr.login_server
      docker_registry_username = data.azurerm_container_registry.acr.admin_username
      docker_registry_password = data.azurerm_container_registry.acr.admin_password
    }
    connection_string {
      name  =  "connection"
      type  = "PostgreSQL"
      value = "dbname='${azurerm_postgresql_server.postgresql_server.name}' user='${random_string.postgresql_user.result}@${azurerm_postgresql_database.postgresql_database.name}' host='${azurerm_postgresql_database.postgresql_database.name}.postgres.database.azure.com' password='${random_password.postgresql_password.result}' port='5432' sslmode='true'"
    }
  }
}