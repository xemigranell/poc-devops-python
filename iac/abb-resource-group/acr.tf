resource "azurerm_container_registry" "acr" {
  #checkov:skip=CKV_AZURE_139:ACR set to disable public networking is a premium sku feature, ours is basic
  #checkov:skip=CKV_AZURE_137:Azure Container Instances needs admin user for pulling the image
  #checkov:skip=CKV_AZURE_163:For a future task
  #checkov:skip=CKV_AZURE_164:For a future task
  #checkov:skip=CKV_AZURE_165:For a future task
  #checkov:skip=CKV_AZURE_166:For a future task
  #checkov:skip=CKV_AZURE_167:For a future task
  name                = "${var.rsg_name}reg${var.env}001"
  resource_group_name = data.azurerm_resource_group.rsg.name
  location            = data.azurerm_resource_group.rsg.location
  sku                 = "Basic"
  admin_enabled       = true
}