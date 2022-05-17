resource "azuread_application_federated_identity_credential" "main" {
  application_object_id = var.object_id
  display_name          = "${var.repo_name}-deploy"
  description           = "Deployments for ${var.repo_name}"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:perrness/${var.repo_name}:ref:refs/heads/main"
}

resource "azuread_application_password" "main" {
  display_name = "${var.repo_name}-client-secret"
  application_object_id = var.object_id
}

data "github_actions_public_key" "main" {
  repository = var.repo_name
}

resource "github_actions_secret" "ad_client_id" {
  repository       = var.repo_name
  secret_name      = "AZURE_AD_CLIENT_ID"
  plaintext_value  = var.application_id
}

resource "github_actions_secret" "ad_tenant_id" {
  repository       = var.repo_name
  secret_name      = "AZURE_AD_TENANT_ID"
  plaintext_value  = var.ad_tenant_id
}

resource "github_actions_secret" "backend_container_name" {
  repository       = var.repo_name
  secret_name      = "AZURE_BACKEND_CONTAINER_NAME"
  plaintext_value  = var.backend_container_name
}

resource "github_actions_secret" "backend_key" {
  repository       = var.repo_name
  secret_name      = "AZURE_BACKEND_KEY"
  plaintext_value  = "${var.repo_name}state.tfstate"
}

resource "github_actions_secret" "backend_resource_group_name" {
  repository       = var.repo_name
  secret_name      = "AZURE_BACKEND_RESOURCE_GROUP_NAME"
  plaintext_value  = var.backend_resource_group_name
}

resource "github_actions_secret" "backend_storage_account_name" {
  repository       = var.repo_name
  secret_name      = "AZURE_BACKEND_STORAGE_ACCOUNT_NAME"
  plaintext_value  = var.backend_storage_account_name
}

resource "github_actions_secret" "client_secret" {
  repository       = var.repo_name
  secret_name      = "AZURE_CLIENT_SECRET"
  plaintext_value  = azuread_application_password.main.value
}

resource "github_actions_secret" "subscription_id" {
  repository       = var.repo_name
  secret_name      = "AZURE_SUBSCRIPTION_ID"
  plaintext_value  = var.subscription_id
}