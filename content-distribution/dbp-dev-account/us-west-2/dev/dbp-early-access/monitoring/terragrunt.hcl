# member-account: dbp-dev

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://github.com/faithcomesbyhearing/fcbh-infrastructure-modules.git//monitoring?ref=v0.1.6"
}

#Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "beanstalk" {
  config_path = "../beanstalk"
  mock_outputs = {
      beanstalk_health_alarm_sns_topic = ""
  }    
}
inputs = {
  namespace         = "dbp"
  stage             = "dev"
  name              = "beanstalk"
  sns_topic_name    = dependency.beanstalk.outputs.beanstalk_health_alarm_sns_topic 
  slack_webhook_url = "https://hooks.slack.com/services/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"
  slack_channel     = "faith-comes-by-he-not"
  slack_username    = "aws"
}
