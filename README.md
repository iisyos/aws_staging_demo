# aws_staging_demo

# Usage 

1. move common resources Terraform directory
```zsh
% cd terraform/common_resources
```
2. create environment variable file by copying from example
```zsh
% cp staging.tfvars.example staging.tfvars
```

3. initialize Terraform and apply
```zsh
% terraform init
% terraform apply -var-file=staging.tfvars
```

4. dump output variables to user dependent environment variable file
```zsh
% cp staging.tfvars ../user_resources/staging.tfvars
% terraform output -json | jq -r 'to_entries[] | "\(.key)=\"\(.value.value)\""' >> ../user_resources/staging.tfvars
```