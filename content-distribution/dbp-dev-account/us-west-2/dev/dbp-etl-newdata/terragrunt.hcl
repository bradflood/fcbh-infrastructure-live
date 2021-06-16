# member-account: dbp-dev

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://github.com/faithcomesbyhearing/fcbh-infrastructure-modules.git//dbp-etl?ref=v0.1.7"
}

#Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id                        = "temporary-dummy-id"
    public_subnet_ids             = []
    private_subnet_ids            = []
    vpc_default_security_group_id = ""
  }
}

dependency "rds" {
  config_path = "../rds"
  mock_outputs = {
    endpoint        = ""
    reader_endpoint = ""
  }
}

inputs = {
  environment = "newdata"
  vpc_id = dependency.vpc.outputs.vpc_id
  ecs_subnets = dependency.vpc.outputs.public_subnet_ids
  ecs_security_group = dependency.vpc.outputs.vpc_default_security_group_id
  database_host = dependency.rds.outputs.endpoint
  acm_certificate_arn = "arn:aws:acm:us-east-1:078432969830:certificate/6d4e6f6b-85b2-49f6-9064-50b16176e8b5"
  alias = "etl.dev.dbt.io"
}
