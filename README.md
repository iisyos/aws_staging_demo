# aws_staging_demo

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

% cp common.tfvars ../user_resources/staging.tfvars
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