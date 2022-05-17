data "azuread_application" "main" {
  display_name = "github-app"
}

data "azurerm_key_vault" "example" {
  name                = "mykeyvault"
  resource_group_name = "some-resource-group"
}

resource "azuread_application_federated_identity_credential" "main" {
  for_each = var.repos

  application_object_id = data.azuread_application.main.object_id
  display_name          = each.value
  description           = "Deployments for ${each.value}"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:perrness/${each.value}:ref:refs/heads/main"
}

data "github_actions_public_key" "main" {
  for_each = var.repos

  repository = each.value
}

resource "github_actions_secret" "azure_ad_client_id" {
  for_each = var.repos

  repository       = each.value
  secret_name      = "AZURE_AD_CLIENT_ID"
  plaintext_value  = data.azuread_application.main.object_id
}

resource "github_actions_secret" "azure_ad_tenant_id" {
  for_each = var.repos

  repository       = each.value
  secret_name      = "AZURE_AD_TENANT_ID"
  plaintext_value  = "c9566794-0e0c-4782-a8c6-11514d711171"
}

resource "github_actions_secret" "azure_backend_container_name" {
  for_each = var.repos

  repository       = each.value
  secret_name      = "AZURE_BACKEND_CONTAINER_NAME"
  plaintext_value  = var.some_secret_string
}

resource "github_actions_secret" "azure_backend_key" {
  for_each = var.repos

  repository       = each.value
  secret_name      = "AZURE_BACKEND_KEY"
  plaintext_value  = var.some_secret_string
}

resource "github_actions_secret" "azure_backend_resource_group_name" {
  for_each = var.repos

  repository       = each.value
  secret_name      = "AZURE_BACKEND_RESOURCE_GROUP_NAME"
  plaintext_value  = var.some_secret_string
}

resource "github_actions_secret" "azure_backend_storage_account_name" {
  for_each = var.repos

  repository       = each.value
  secret_name      = "AZURE_BACKEND_STORAGE_ACCOUNT_NAME"
  plaintext_value  = var.some_secret_string
}

resource "github_actions_secret" "azure_client_secret" {
  for_each = var.repos

  repository       = each.value
  secret_name      = "AZURE_CLIENT_SECRET"
  plaintext_value  = var.some_secret_string
}

resource "github_actions_secret" "azure_subscription_id" {
  for_each = var.repos

  repository       = each.value
  secret_name      = "AZURE_SUBSCRIPTION_ID"
  plaintext_value  = var.some_secret_string
}