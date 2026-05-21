##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

# associations:                              # (Optional) List of SSO permission set associations. Default: []
#   - permission_set: "AdministratorAccess"  # (Required) Name of the AWS SSO permission set
#     group_name: "Admins"                   # (Optional) Identity store group display name; mutually exclusive with user_name
#   - permission_set: "ReadOnlyAccess"       # (Required) Name of the AWS SSO permission set
#     user_name: "john.doe@example.com"      # (Optional) Identity store username; mutually exclusive with group_name
variable "associations" {
  description = "List of SSO account assignment objects; each entry requires permission_set and exactly one of group_name or user_name (Optional, default: [])"
  type        = any
  default     = []
}

# account_id: "123456789012"  # (Required) AWS account ID for the SSO target account
variable "account_id" {
  description = "AWS account ID for the SSO target account (Required)"
  type        = string
}

# account_arn: "arn:aws:organizations::123456789012:account/o-exampleorgid/123456789012"  # (Required) AWS account ARN for the SSO target account
variable "account_arn" {
  description = "AWS account ARN for the SSO target account (Required)"
  type        = string
}