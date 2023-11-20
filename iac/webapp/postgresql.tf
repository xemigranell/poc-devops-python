resource "random_string" "postgresql_user" {
  length  = 6
  special = false
}

resource "random_password" "postgresql_password" {
  length  = 16
  special = false
}

resource "azurerm_postgresql_server" "postgresql_server" {
  name                = "${var.rsg_name}-pse-${var.env}-001"
  location            = azurerm_resource_group.rsg.location
  resource_group_name = azurerm_resource_group.rsg.name

  sku_name = "B_Gen4_1"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  administrator_login          = random_string.postgresql_user.result
  administrator_login_password = random_password.postgresql_password.result
  version                      = "11"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "postgresql_database" {
  name                = "${var.rsg_name}-pdb-${var.env}-001"
  resource_group_name = azurerm_resource_group.rsg.name
  server_name         = azurerm_postgresql_server.postgresql_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}