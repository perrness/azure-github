data "azuread_application" "main" {
  display_name = "github-app"
}

data "azurerm_key_vault" "main" {
  name                = "perkv"
  resource_group_name = "per-kv-rg"
}

data "azurerm_key_vault_secret" "backend_storage_account_name" {
  name         = "AZURE-BACKEND-STORAGE-ACCOUNT-NAME"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "backend_resource_group_name" {
  name         = "AZURE-BACKEND-RESOURCE-GROUP-NAME"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "backend_container_name" {
  name         = "AZURE-BACKEND-CONTAINER-NAME"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "ad_tenant_id" {
  name         = "AZURE-AD-TENANT-ID"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "subscription_id" {
  name         = "AZURE-SUBSCRIPTION-ID"
  key_vault_id = data.azurerm_key_vault.main.id
}

module "github_action_secrets" {
  for_each = toset(var.repos)

  source = "./modules/githubsecrets"

  repo_name                    = each.value
  application_id               = data.azuread_application.main.application_id
  ad_tenant_id                 = data.azurerm_key_vault_secret.ad_tenant_id.value
  subscription_id              = data.azurerm_key_vault_secret.subscription_id.value
  backend_resource_group_name  = data.azurerm_key_vault_secret.backend_resource_group_name.value
  backend_storage_account_name = data.azurerm_key_vault_secret.backend_storage_account_name.value
  backend_container_name       = data.azurerm_key_vault_secret.backend_container_name.value
}
