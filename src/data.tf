data "github_repository" "ninja422" {
  full_name = var.target_repository_full_name
}

data "external" "secret" {
  program = ["echo", "{ \"key\": \"value\", \"another key\": \"value\" }"]
  query = { }
}
