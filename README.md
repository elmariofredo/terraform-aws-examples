# Terraform examples

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.51.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_auditlog"></a> [aws\_auditlog](#module\_aws\_auditlog) | ./modules/aws_auditlog | n/a |
| <a name="module_aws_s3_bucket_base_fluentbit-logs"></a> [aws\_s3\_bucket\_base\_fluentbit-logs](#module\_aws\_s3\_bucket\_base\_fluentbit-logs) | ./modules/aws_s3_bucket_base | n/a |
| <a name="module_aws_s3_bucket_base_some_awesome_tool"></a> [aws\_s3\_bucket\_base\_some\_awesome\_tool](#module\_aws\_s3\_bucket\_base\_some\_awesome\_tool) | ./modules/aws_s3_bucket_base | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.test_appslogs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_access_key.test_tools_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.test_appslogs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user.test_tools_write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_kms_key.dev](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | n/a | `string` | n/a | yes |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_kms_key_dev"></a> [aws\_kms\_key\_dev](#output\_aws\_kms\_key\_dev) | n/a |
| <a name="output_test_appslogs_aws_access_key_id"></a> [test\_appslogs\_aws\_access\_key\_id](#output\_test\_appslogs\_aws\_access\_key\_id) | n/a |
| <a name="output_test_appslogs_aws_secret_access_key"></a> [test\_appslogs\_aws\_secret\_access\_key](#output\_test\_appslogs\_aws\_secret\_access\_key) | n/a |
| <a name="output_test_tools_write_aws_access_key_id"></a> [test\_tools\_write\_aws\_access\_key\_id](#output\_test\_tools\_write\_aws\_access\_key\_id) | n/a |
| <a name="output_test_tools_write_aws_secret_access_key"></a> [test\_tools\_write\_aws\_secret\_access\_key](#output\_test\_tools\_write\_aws\_secret\_access\_key) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
