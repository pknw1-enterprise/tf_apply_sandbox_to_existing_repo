This module is to apply enhanced workflows and configuration to existing project repositories

- user passes in list of workflows to process
- for each workflow 
  - the workflow yaml is created 
  - the workflow readme is created
  - a new branch is created named "${workflow}-installation"
  - the yaml and readme files are added to the branch
  - the branch is committed and pushed to the remote
  - a PR is raised for each

```
module "sandbox" {
  source = "../"

  github_org                    = "edfenergy"
  target_repository_full_name   = "pknw1/tf_target"
  commit_message                = "as" 
  commit_author                 = "as"
  commit_email                  = "s"
  overwrite_on_create           = true
  apps                          = ["sandbox_workflow", "rover_workflow", "tfsec_workflow"] 
}
```