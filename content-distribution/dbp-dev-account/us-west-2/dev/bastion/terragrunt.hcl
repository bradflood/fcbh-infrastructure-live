# dpb-api bastion host

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../../../fcbh-infrastructure-modules//bastion"
  #source = "git::https://github.com/faithcomesbyhearing/fcbh-infrastructure-modules.git?ref=master"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}
dependency "vpc" {
  config_path = "../vpc"
}

inputs = {

  namespace = "dbp"
  stage     = "dev"
  name      = "api"

  vpc_id    = dependency.vpc.outputs.vpc_id
  control_cidr = ["140.82.163.2/32", "73.26.9.216/32", "45.58.38.254/32", "136.37.119.153/32"]
  key_name = "dbp"
  subnet_id   = dependency.vpc.outputs.bastion_subnet_id
}
