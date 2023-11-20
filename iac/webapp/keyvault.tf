resource "azurerm_key_vault_secret" "postgresql_admin_user" {
  #checkov:skip=CKV_AZURE_114:Content type not needed
  #checkov:skip=CKV_AZURE_41:Currently it has not expire date
  name         = "postgresql-admin-user"
  value        = random_string.postgresql_user.result
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "postgresql_admin_pass" {
  #checkov:skip=CKV_AZURE_114:Content type not needed
  #checkov:skip=CKV_AZURE_41:Currently it has not expire date
  name         = "postgresql-admin-password"
  value        = random_password.postgresql_password.result
  key_vault_id = data.azurerm_key_vault.keyvault.id
}