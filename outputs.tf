##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "sso_instance_arn" {
  description = "ARN of the AWS SSO instance used for account assignments"
  value       = data.aws_ssoadmin_instances.sso.arns[0]
}

output "group_assignment_ids" {
  description = "Map of group SSO account assignment resource IDs, keyed by 'permission_set-group_name'"
  value = {
    for k, v in aws_ssoadmin_account_assignment.group_assignment : k => v.id
  }
}

output "user_assignment_ids" {
  description = "Map of user SSO account assignment resource IDs, keyed by 'permission_set-user_name'"
  value = {
    for k, v in aws_ssoadmin_account_assignment.user_assignment : k => v.id
  }
}
