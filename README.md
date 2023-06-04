# aws_staging_demo
This repository is a demo for AWS *Staging* environment.
Supposed some situation like
- Need AWS Fargate *Staging* environment
- Each developer needs a unique *Staging* environment
- And each developer can deploy to their own *Staging* environment at their own timing

I solved this problem by using `Terraform` and CI/CD.
Each *Staging* environment shares some resources.(VPC etc.)

# Usage
I assume `Terraform` is already installed, and created IAM user for it.
Fist of all, create [backend](https://developer.hashicorp.com/terraform/language/settings/backends/s3).
```zsh
% BUCKET_NAME=hoge_bucket
% aws s3 mb $BUCKET_NAME
```

Next, copy `main_override.tf.example` to `main_override.tf` and set your bucket name.
```zsh
# for common resources
% sed "s/bucket = \"mybucket\"/bucket = \"$BUCKET_NAME\"/" terraform/common_resources/main_override.tf.example > terraform/common_resources/main_override.tf
# for user resources
% sed "s/bucket = \"mybucket\"/bucket = \"$BUCKET_NAME\"/" terraform/user_resources/main_override.tf.example > terraform/user_resources/main_override.tf
```

It's time to deploy Terraform resources🚀.


## Common resources
Common resources mean literally common resources for all users, such as VPC, Subnet, Security Group, etc.

1. move common resources Terraform directory
```zsh
% cd terraform/common_resources
```

2. create environment variable file by copying from example, and edit it
```zsh
% cp common.tfvars.example common.tfvars
```
3. initialize Terraform and apply by using environment variable file
```zsh
% terraform init
% terraform apply -var-file=common.tfvars
```

## User resources

User resources create resources for each user.
There two way of deploying this resources.
One is deploy by human, and the other is deploy by CI/CD.
This section describes how to deploy by human.

1. dump output variables to user dependent environment variable file
```zsh
$ pwd
path/to/aws_staging_demo/terraform/common_resources

% cp ../user_resources/staging.tfvars.exampe ../user_resources/staging.tfvars
% terraform output -json | jq -r 'to_entries[] | "\(.key)=\"\(.value.value)\""' >> ../user_resources/staging.tfvars
```

2. move user resources Terraform directory
```zsh
% cd ../user_resources
```

3. edit environment variable file for your application(especially `environment`)

4. initialize Terraform and apply by using environment variable file
```zsh
% terraform init
% terraform apply -var-file=staging.tfvars
```

# CI/CD
GitHub Actions is used for CI/CD.
The staging deploy workflow triggered by [workflow_dispatch](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow).
First time, Terraform create below resources.
- ECS
  - Cluster
  - Task Definition
  - Service
- ALB
  - listener
  - target group
- Route53
  - A record

You can access to your staging environment by accessing to `http://<your github username>.<your domain>`.
After that, Terraform update Task Definition, and restart ECS Service.

# Note
- This repository is just a demo, so it doesn't have any test.
- SSL certificate is not included in this repository.
- This repository doesn't have any resources for like `production` environment. (common_resources has `production` , but it's just a dummy.)
- I use tricky forcible way to manage user dependent parameters. So in the future, I need to change this way to more robust way. Install [Terragrunt](https://terragrunt.gruntwork.io/) is one possible way.