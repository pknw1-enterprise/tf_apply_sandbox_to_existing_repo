resource "github_branch" "ninja422" {
  for_each = local.local_workflows
  repository = data.github_repository.ninja422.name
  branch     = "${each.key}-installation"
}

resource "github_branch" "ninja422i" {
  repository = data.github_repository.ninja422.name
  branch     = "integrate_workflows_into_main_repository"
}

resource "github_repository_file" "ninja422" {
  for_each = local.local_workflows

  repository          = data.github_repository.ninja422.name
  branch              = "${github_branch.ninja422[each.key].branch}"
  file                = ".github/workflows/${each.key}.yml"
  content             = "${each.value.workflow_content}"
  commit_message      = var.commit_message
  commit_author       = var.commit_author
  commit_email        = var.commit_email
  overwrite_on_create = var.overwrite_on_create

  depends_on = [
    github_branch.ninja422,
    local_file.terraform_sandbox,
    local_file.workflow_rover,
    local_file.workflow_tfsec
  ]
}

resource "github_repository_file" "ninja422readme" {
  for_each = local.local_workflows

  repository          = data.github_repository.ninja422.name
  branch              = "${github_branch.ninja422[each.key].branch}"
  file                = ".github/workflows/${each.key}_readme.md"
  content             = "${each.value.readme_content}"
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true

  depends_on = [
    github_branch.ninja422,
    github_repository_file.ninja422
  ]
}

resource "github_repository_file" "super" {

  repository          = data.github_repository.ninja422.name
  branch              = "${github_branch.ninja422i.branch}"
  file                = "workflow-updates.md"
  content             = local.workflow-updates-content
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true

  depends_on = [
    github_repository_pull_request.ninja422
  ]
}


resource "github_repository_pull_request" "ninja422" {
    for_each = local.local_workflows

    base_repository = data.github_repository.ninja422.name
    base_ref        = "${github_branch.ninja422i.ref}"
    head_ref        = "${github_branch.ninja422[each.key].ref}"
    title           = "${each.key} installation"
    body            = each.value.readme_content

 depends_on = [
    github_repository_file.ninja422readme
  ]
}


resource "github_repository_pull_request" "ninja422i" {

    base_repository = data.github_repository.ninja422.name
    base_ref        = "main"
    head_ref        = "${github_branch.ninja422i.ref}"
    title           = "Merge Approved Workfloews"
    body            = local.integrate_workflows_pr_body

 depends_on = [
    github_repository_file.super
  ]
}