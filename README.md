<!-- 
  ** DO NOT EDIT THIS FILE
  ** 
  ** This file was automatically generated. 
  ** 1) Make all changes to `README.yaml` 
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file. 
  -->
[![README Header][readme_header_img]][readme_header_link]

[![cloudopsworks][logo]](https://cloudops.works/)

# Terraform AWS SSO Account Associations Module




The *terraform-module-aws-sso-account-associations* module helps you manage AWS SSO account 
associations by assigning permission sets to IAM groups and users across multiple AWS accounts. 
It leverages AWS Single Sign-On to ensure that specified users or groups get assigned the relevant 
permission sets in the desired AWS accounts. This module significantly simplifies and centralizes the 
management of SSO account assignments.


---

This project is part of our comprehensive approach towards DevOps Acceleration. 
[<img align="right" title="Share via Email" width="24" height="24" src="https://docs.cloudops.works/images/ionicons/ios-mail.svg"/>][share_email]
[<img align="right" title="Share on Google+" width="24" height="24" src="https://docs.cloudops.works/images/ionicons/logo-googleplus.svg" />][share_googleplus]
[<img align="right" title="Share on Facebook" width="24" height="24" src="https://docs.cloudops.works/images/ionicons/logo-facebook.svg" />][share_facebook]
[<img align="right" title="Share on Reddit" width="24" height="24" src="https://docs.cloudops.works/images/ionicons/logo-reddit.svg" />][share_reddit]
[<img align="right" title="Share on LinkedIn" width="24" height="24" src="https://docs.cloudops.works/images/ionicons/logo-linkedin.svg" />][share_linkedin]
[<img align="right" title="Share on Twitter" width="24" height="24" src="https://docs.cloudops.works/images/ionicons/logo-twitter.svg" />][share_twitter]


[![Terraform Open Source Modules](https://docs.cloudops.works/images/terraform-open-source-modules.svg)][terraform_modules]



It's 100% Open Source and licensed under the [APACHE2](LICENSE).







We have [*lots of terraform modules*][terraform_modules] that are Open Source and we are trying to get them well-maintained!. Check them out!






## Introduction

This module is designed to automate the creation and maintenance of AWS SSO (IAM Identity Center) account 
assignments for users and groups across different AWS accounts. It supports a flexible, YAML-based input 
structure for defining assignments—grouping which users/groups should get which permission sets in which 
accounts.
<br/>
Additionally, you can bootstrap your infrastructure code using Terragrunt and the Gruntwork boilerplate 
template included in the .boilerplate folder. By running terragrunt scaffold, you can quickly generate 
standardized file structures and configurations for your infrastructure. This encourages best practices 
and a clean layout for your Terraform/Terragrunt code.

## Usage


**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases.
Instead pin to the release tag (e.g. `?ref=vX.Y.Z`) of one of our [latest releases](https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations/releases).


In your Terragrunt or Terraform configuration, reference the module. For Terragrunt, you might do something like:

```hcl
terraform {
  source = “git::https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations.git?ref=develop”
}

inputs = {
  account_assignments = {
    # Example of YAML-style definition within Terragrunt:
    devOpsTeam:
      accounts:
        - “111111111111”
        - “222222222222”
    groups:
      - “devops-group”
    users:
      - “devops-user@example.com”
    permission_sets:
      - “arn:aws:sso:::permissionSet/ps-1234567890abcdef”
  financeTeam:
    accounts:
      - “333333333333”
    groups:
      - “finance-group”
    permission_sets:  
      - “arn:aws:sso:::permissionSet/ps-fedcba9876543210”
  }
}

```
- account_assignments: This variable expects a map of keys (e.g., devOpsTeam, financeTeam) where each key is an organizational label. Within each label, you define:
- accounts: A list of AWS account IDs.
- groups: A list of IAM Identity Center groups to assign.
- users: A list of IAM Identity Center users to assign.
- permission_sets: A list of permission set ARNs.

## Quick Start

1. Clone the repository or reference this module in your existing Terragrunt/Terraform configuration.
2. Run terragrunt scaffold to initialize a new environment with the Gruntwork boilerplate templates:
```bash
terragrunt scaffold
```
This command will create a directory structure with recommended best practices.
3. Configure the module inputs by editing the generated Terragrunt HCL files (or .auto.tfvars), referencing the variables documented below.
4. Review and validate your configuration to ensure all accounts, users, groups, and permission sets are correctly defined.
5. Deploy the module using:

```bash
terragrunt run-all apply
```
This will create or update your AWS SSO account assignments.


## Examples

### Basic Example

```hcl

module “aws_sso_account_associations” {

source = “git::https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations.git?ref=develop”



account_assignments = {

exampleRole:

accounts:

- “111111111111”

groups:

- “admin-group”

users:

- “admin-user@example.com”

permission_sets:

- “arn:aws:sso:::permissionSet/ps-aaaaaaaaaaaaaaaa”

}

}

```



### Using Terragrunt Scaffold

After running terragrunt scaffold, you’ll have a recommended folder structure. In your environment folder, say live/prod/ssomanagement/terragrunt.hcl, you can reference:

```hcl

include {

path = find_in_parent_folders()

}



terraform {

source = “git::https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations.git?ref=develop”

}



inputs = {

account_assignments = yamldecode(file(”${get_parent_terragrunt_dir()}/env-config/sso-assignments.yaml”))

}

```



Where sso-assignments.yaml might look like:

```yaml

securityTeam:

accounts:

- “444444444444”

- “555555555555”

users:

- “sec-user1@example.com”

- “sec-user2@example.com”

permission_sets:

- “arn:aws:sso:::permissionSet/ps-bbbbbbbbbbbbbbbb”



opsTeam:

accounts:

- “666666666666”

groups:

- “ops-group”

permission_sets:

- “arn:aws:sso:::permissionSet/ps-cccccccccccccccc”

```



## Makefile Targets
```
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint terraform/opentofu code
  tag                                 Tag the current version

```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [aws_ssoadmin_account_assignment.group_assignment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_ssoadmin_account_assignment.user_assignment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssoadmin_account_assignment) | resource |
| [aws_identitystore_group.group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/identitystore_group) | data source |
| [aws_identitystore_user.user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/identitystore_user) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_ssoadmin_instances.sso](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_instances) | data source |
| [aws_ssoadmin_permission_set.group_permission_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_permission_set) | data source |
| [aws_ssoadmin_permission_set.user_permission_set](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssoadmin_permission_set) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_arn"></a> [account\_arn](#input\_account\_arn) | The AWS account ARN for the SSO instance | `string` | n/a | yes |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The AWS account ID for the SSO instance | `string` | n/a | yes |
| <a name="input_associations"></a> [associations](#input\_associations) | List of permission set associations to create in the identity store | `any` | `[]` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Establish this is a HUB or spoke configuration | `bool` | `false` | no |
| <a name="input_org"></a> [org](#input\_org) | n/a | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | n/a | `string` | `"001"` | no |

## Outputs

No outputs.



## Help

**Got a question?** We got answers. 

File a GitHub [issue](https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations/issues), send us an [email][email] or join our [Slack Community][slack].

[![README Commercial Support][readme_commercial_support_img]][readme_commercial_support_link]

## DevOps Tools

## Slack Community


## Newsletter

## Office Hours

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations/issues) to report any bugs or file feature requests.

### Developing




## Copyrights

Copyright © 2024-2025 [Cloud Ops Works LLC](https://cloudops.works)





## License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.









## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## About

This project is maintained by [Cloud Ops Works LLC][website]. 


### Contributors

|  [![Cristian Beraha][berahac_avatar]][berahac_homepage]<br/>[Cristian Beraha][berahac_homepage] |
|---|

  [berahac_homepage]: https://github.com/berahac
  [berahac_avatar]: https://github.com/berahac.png?size=50

[![README Footer][readme_footer_img]][readme_footer_link]
[![Beacon][beacon]][website]

  [logo]: https://cloudops.works/logo-300x69.svg
  [docs]: https://cowk.io/docs?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=docs
  [website]: https://cowk.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=website
  [github]: https://cowk.io/github?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=github
  [jobs]: https://cowk.io/jobs?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=jobs
  [hire]: https://cowk.io/hire?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=hire
  [slack]: https://cowk.io/slack?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=slack
  [linkedin]: https://cowk.io/linkedin?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=linkedin
  [twitter]: https://cowk.io/twitter?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=twitter
  [testimonial]: https://cowk.io/leave-testimonial?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=testimonial
  [office_hours]: https://cloudops.works/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=office_hours
  [newsletter]: https://cowk.io/newsletter?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=newsletter
  [email]: https://cowk.io/email?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=email
  [commercial_support]: https://cowk.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=commercial_support
  [we_love_open_source]: https://cowk.io/we-love-open-source?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=we_love_open_source
  [terraform_modules]: https://cowk.io/terraform-modules?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=terraform_modules
  [readme_header_img]: https://cloudops.works/readme/header/img
  [readme_header_link]: https://cloudops.works/readme/header/link?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=readme_header_link
  [readme_footer_img]: https://cloudops.works/readme/footer/img
  [readme_footer_link]: https://cloudops.works/readme/footer/link?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=readme_footer_link
  [readme_commercial_support_img]: https://cloudops.works/readme/commercial-support/img
  [readme_commercial_support_link]: https://cloudops.works/readme/commercial-support/link?utm_source=github&utm_medium=readme&utm_campaign=cloudopsworks/terraform-module-aws-sso-account-associations&utm_content=readme_commercial_support_link
  [share_twitter]: https://twitter.com/intent/tweet/?text=Terraform+AWS+SSO+Account+Associations+Module&url=https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations
  [share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AWS+SSO+Account+Associations+Module&url=https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations
  [share_reddit]: https://reddit.com/submit/?url=https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations
  [share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations
  [share_googleplus]: https://plus.google.com/share?url=https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations
  [share_email]: mailto:?subject=Terraform+AWS+SSO+Account+Associations+Module&body=https://github.com/cloudopsworks/terraform-module-aws-sso-account-associations
  [beacon]: https://ga-beacon.cloudops.works/G-7XWMFVFXZT/cloudopsworks/terraform-module-aws-sso-account-associations?pixel&cs=github&cm=readme&an=terraform-module-aws-sso-account-associations
