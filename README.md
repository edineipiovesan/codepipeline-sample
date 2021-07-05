# codepipeline-sample
A simple pipeline that checkout code from GitHub, build and test a java application, create docker image and upload to AWC ECR using AWS Code PIpeline and built with Terraform IaC.

## Prerequisites

1. [Terraform](https://www.terraform.io/downloads.html)
2. [AWS Credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) 

## How-to

1. Edit `pipeline/terraform/backend.tf` if you want to use [terraform backend](https://www.terraform.io/docs/language/settings/backends/index.html), otherwide this file can be deleted
2. Setup [Dockerhub](https://hub.docker.com/) credentials using [AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/tutorials_basic.html#tutorial-basic-step1)
3. Fill inputs in `pipeline/terraform/input.tfvars` file
4. Run `terraform init` from `pipeline/terraform` path
5. Run `terraform plan -var-file=input.tfvars` to show all resources that will be created
6. Run `terraform apply -var-file=input.tfvars` to apply all changes previously planned
7. Log-in to AWS Console to approve GitHub connection in `CodePipeline > Settings > Connections`