##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

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