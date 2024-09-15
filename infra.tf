data "github_repository" "self" {
  full_name = "maximveksler/github-terraform-provider-bug"

}

resource "github_repository_environment" "bug" {
  environment = "dev:dry-run"
  repository  = data.github_repository.self.name
}

variable "vars" {
  type = map(string)
  default = {
    AWS_REGION                                = "value1"
    AWS_PROFILE                               = "value2"
    AWS_ROLE_TO_ASSUME                        = "value3"
    AZURE_CLIENT_ID                           = "value4"
  }
}

resource "github_actions_environment_variable" "bug-vars" {
  for_each      = var.vars
  repository    = data.github_repository.self.name
  environment   = github_repository_environment.bug.environment
  variable_name = each.key
  value         = each.value
}
