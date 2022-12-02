resource "local_file" "workflow_tfsec" {
    content  = <<EOF

name: 'Manual Control of Terraform Local Deployments'

on:
  workflow_dispatch:
    inputs:
      terraform_folder:
        required: true
        type: string
      terraform_branch:
        required: true
        default: "main"
        type: string
      validate:
        required: false
        default: true
        type: boolean      
      plan:
        required: false
        default: true
        type: boolean
      apply:
        required: false
        default: false
        type: boolean
      destroy: 
        required: false
        default: false
        type: boolean
      status: 
        required: false
        default: false
        type: boolean

      deployment_identifier:
        required: true
        type: string

env:
  ARM_SUBSCRIPTION_ID: "$${{ secrets.ARM_SUBSCRIPTION_ID }}"
  ARM_TENANT_ID: "$${{ secrets.ARM_TENANT_ID }}"
  ARM_CLIENT_ID: "$${{ secrets.ARM_CLIENT_ID }}"
  ARM_CLIENT_SECRET: "$${{ secrets.ARM_CLIENT_SECRET }}"
  TF_VAR_project_name: $${{ inputs.sandbox_identifier }}

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: terradform-run
        uses: edfenergy/eit-devops-az-custom-github-actions@terraform_sandbox_control
        with:
          folder: $${{ inputs.terraform_folder }}
          branch_name: $${{ inputs.terraform_branch }}
          deployment_identifier: $${{ inputs.deployment_identifier }}
          encryptionkey: $${{ secrets.encryptionkey }}
          validate: $${{ inputs.validate }}
          plan: $${{ inputs.plan }}
          apply: $${{ inputs.apply }}
          status: $${{ inputs.status }}
          destroy: $${{ inputs.destroy }}
          custom_plan_flags: '' 
          custom_apply_flags: ''
    EOF
    filename = "${path.module}/generated_files/workflow_tfsec.yml"
}

resource "local_file" "workflow_tfsec_readme" {
    content  = <<EOF
## Summary
To facilitate a developer being able to rapidly test their local terraform code in a realistic manner, any developer can leverage the following features

1. provision production like resources and azure subscription to flexibly test their code from their local machine directly - unhindered by quality and policy checks that while essential when progressing to production, can severely limit rapid development <br>               .
  - either the developer can create a new branch prefixed with sandbox- which triggers the automatic deployment of sandbox infrastructure
  - invoke the Manual Deployment process - which allows them to 
    - choose a new branch name 
    - select the repo folder to deploy the sandbox  infrastructure 
    - performa additional actions, such as terraform plan, terraform show and exporting a tfsec visualisation 
    - delete the deployment at will
  - expiry dates

2. Configure pre-development options that suit them
  - disable plan
  - disable tfsec
  - etc
    EOF
    filename = "${path.module}/generated_files/tfsec_readme.md"

    depends_on = [ local_file.workflow_tfsec ]
}
