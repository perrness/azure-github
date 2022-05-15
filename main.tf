data "azuread_application" "main" {
  display_name = "github-app"
}

resource "azuread_application_federated_identity_credential" "main" {
  application_object_id = azuread_application.main.object_id
  display_name          = "my-repo-deploy"
  description           = "Deployments for my-repo"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:perrness/terraform-azure-github-credentials:ref:refs/heads/main"
}