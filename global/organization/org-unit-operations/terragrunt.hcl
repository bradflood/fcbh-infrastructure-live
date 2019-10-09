# Organization: DBP
#      Organizational Unit: Operations

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../fcbh-infrastructure-modules//organizational-unit"
}

# #Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}
dependency "organization" {
  config_path = "../dbp"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  organization_id                     = dependency.organization.outputs.organization_id
  organization_master_account_id      = dependency.organization.outputs.organization_master_account_id
  organization_unit_name              = "Operations"
  member_account_name                 = "DBP Production"
  member_account_email                = "bubcus@example.org"
  iam_users_accessing_member_account  = ["bwflood"]
  role_arn_referencing_member_account = { "dbp@prod" = "arn:aws:iam::627672411722:role/OrganizationAccountAccessRole" }
}