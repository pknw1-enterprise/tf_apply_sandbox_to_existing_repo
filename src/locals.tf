
locals {

  integrate_workflows_pr_body = <<EOT
  ## PR Commit
  EOT

  workflow-updates-content = <<EOF
  installed workflows
  EOF

  local_workflows = { for k, v in local.config : k => v if contains(var.apps, k) }

  config = {
    sandbox_workflow = {
      name              = "sandbox_workflow"
      workflow_content  = "${local_file.terraform_sandbox.content}"
      readme_content    = "${local_file.terraform_sandbox_readme.content}"
      pr_body           = "Pull Request Details"
      secrets           = "${data.external.secret}"
    }
    rover_workflow = {
      name              = "rover_workflow"
      workflow_content  = "${local_file.workflow_rover.content}"
      readme_content    = "${local_file.workflow_rover_readme.content}"
      pr_body           = "Pull Request Details"
      secrets           = "${data.external.secret}"
    }
    tfsec_workflow = {
      name              = "tfsec_workflow"
      workflow_content  = "${local_file.workflow_tfsec.content}"
      readme_content    = "${local_file.workflow_tfsec_readme.content}"
      pr_body           = "Pull Request Details"
      secrets           = "${data.external.secret}"
    } 
  }

}