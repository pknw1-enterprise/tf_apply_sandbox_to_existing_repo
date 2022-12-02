output "org" {
  value = var.github_org
}

output "repo" {
  value = data.github_repository.ninja422.full_name
}

output "installed_apps" {
    value = { for app in var.apps : app => local.local_workflows[app].name } 
}
