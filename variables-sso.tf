##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

## YAML settings
# sso_associations:
#   - permission_set: "AdministratorAccess"
#     group_name: "Admins"
#   - permission_set: "PowerUserAccess"
#     group_name: "PowerUsers"
variable "associations" {
  description = "List of permission set associations to create in the identity store"
  type        = any
  default     = []
}

variable "account_id" {
  description = "The AWS account ID for the SSO instance"
  type        = string
}

variable "account_arn" {
  description = "The AWS account ARN for the SSO instance"
  type        = string
}