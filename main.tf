##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  group_associations = [
    for item in var.associations : {
      group_name     = item.group_name
      permission_set = item.permission_set
    } if try(item.group_name, "") != ""
  ]
  user_associations = [
    for item in var.associations : {
      user_name      = item.user_name
      permission_set = item.permission_set
    } if try(item.user_name, "") != ""
  ]
}

data "aws_ssoadmin_instances" "sso" {}

data "aws_ssoadmin_permission_set" "group_permission_set" {
  for_each = {
    for item in local.group_associations : "${item.permission_set}-${item.group_name}" => item
  }
  instance_arn = data.aws_ssoadmin_instances.sso.arns[0]
  name         = each.value.permission_set
}

data "aws_identitystore_group" "group" {
  for_each = {
    for item in local.group_associations : "${item.permission_set}-${item.group_name}" => item
  }
  identity_store_id = data.aws_ssoadmin_instances.sso.identity_store_ids[0]
  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.value.group_name
    }
  }
}

data "aws_identitystore_user" "user" {
  for_each = {
    for item in local.user_associations : "${item.permission_set}-${item.user_name}" => item
  }
  identity_store_id = data.aws_ssoadmin_instances.sso.identity_store_ids[0]
  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = each.value.user_name
    }
  }
}

data "aws_ssoadmin_permission_set" "user_permission_set" {
  for_each = {
    for item in local.user_associations : "${item.permission_set}-${item.user_name}" => item
  }
  instance_arn = data.aws_ssoadmin_instances.sso.arns[0]
  name         = each.value.permission_set
}

resource "aws_ssoadmin_account_assignment" "group_assignment" {
  for_each = {
    for item in local.group_associations : "${item.permission_set}-${item.group_name}" => item
  }
  instance_arn       = data.aws_ssoadmin_instances.sso.arns[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.group_permission_set[each.key].arn
  principal_id       = data.aws_identitystore_group.group[each.key].group_id
  principal_type     = "GROUP"
  target_id          = var.account_id
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "user_assignment" {
  for_each = {
    for item in local.user_associations : "${item.permission_set}-${item.user_name}" => item
  }
  instance_arn       = data.aws_ssoadmin_instances.sso.arns[0]
  permission_set_arn = data.aws_ssoadmin_permission_set.user_permission_set[each.key].arn
  principal_id       = data.aws_identitystore_user.user[each.key].user_id
  principal_type     = "USER"
  target_id          = var.account_id
  target_type        = "AWS_ACCOUNT"
}