## Summary
To facilitate a developer being able to rapidly test their local terraform code in a realistic manner, any developer can leverage the following features

1. provision production like resources and azure subscription to flexibly test their code from their local machine directly - unhindered by quality and policy checks that while essential when progressing to production, can severely limit rapid development <br>               .
  - either the developer can create a new branch prefixed with sandbox- which triggers the automatic deployment of sandbox infrastructure
  - invoke the Manual Deployment process - which allows them to 
    - choose a new branch name 
    - select the repo folder to deploy the sandbox  infrastructure 
    - performa additional actions, such as terraform plan, terraform show and exporting a rover visualisation 
    - delete the deployment at will
  - expiry dates

2. Configure pre-development options that suit them
  - disable plan
  - disable rover
  - etc
