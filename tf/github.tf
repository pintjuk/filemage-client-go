resource "github_repository" "filemage_client_go_repo" {
  name        = local.repo_name
  description = "Go client for filemage api"

  visibility         = "public"
  allow_squash_merge = false
  allow_rebase_merge = false
  archive_on_destroy = true
}

data "github_branch" "main" {
  repository = github_repository.filemage_client_go_repo.name
  branch     = "main"
  depends_on = [github_repository.filemage_client_go_repo]
}

resource "github_branch_default" "default_main" {
  repository = github_repository.filemage_client_go_repo.name
  branch     = data.github_branch.main.branch

  depends_on = [data.github_branch.main]
}

#resource "github_app_installation_repository" "install_cloud_build_in_repo" {
#  # The installation id of the app (in the organization).
#  installation_id = local.cloud_build_instalation.id
#  repository      = github_repository.project_repo.name
#}

resource "github_branch_protection" "branch_protection_for_repo" {
  repository_id = github_repository.filemage_client_go_repo.node_id
  # also accepts repository name
  # repository_id  = github_repository.example.name

  pattern                         = "main"
  enforce_admins                  = false
  allows_deletions                = false
  require_conversation_resolution = true

  required_status_checks {
    strict = true
    #contexts = ["ci/travis"]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    restrict_dismissals             = true
    required_approving_review_count = 1
  }

  push_restrictions = [
    data.github_user.daniil.node_id,
    # limited to a list of one type of restriction (user, team, app)
    # github_team.example.node_id
  ]
  depends_on = [data.github_branch.main]
}

#data "github_team" "enplore_devs" {
#  slug = "enplore-devs"
#}




data "github_user" "daniil" {
  username = "pintjuk"
}


#resource "github_team_repository" "grant_boeing_devs_push" {
#  team_id    = data.github_team.boeing_devs.id
#  repository = github_repository.project_repo.name
#  permission = "push"
#}


resource "github_repository_collaborator" "grant_daniil_admin" {
  repository = github_repository.filemage_client_go_repo.name
  username   = data.github_user.daniil.username
  permission = "admin"
  depends_on = [github_repository.filemage_client_go_repo]
}


#resource "github_repository_collaborator" "grant_bivald_admin" {
#  repository = local.repo_name
#  username   = data.github_user.bivald.username
#  permission = "admin"
#}
#
#resource "github_repository_collaborator" "grant_machine_admin" {
#  repository = local.repo_name
#  username   = data.github_user.machine.username
#  permission = "admin"
#}
