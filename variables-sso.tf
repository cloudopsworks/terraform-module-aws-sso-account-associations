##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
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