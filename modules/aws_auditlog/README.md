# Create aws auditlog bucket

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.53.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_athena_database.audit_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_database) | resource |
| [aws_iam_group.aditlogs_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.aditlogs_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy.aditlogs_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [null_resource.create_athena_auditlog_table](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Athena auditlog database name | `string` | `"audit_log"` | no |
| <a name="input_lifecycle_rule_expiration_days"></a> [lifecycle\_rule\_expiration\_days](#input\_lifecycle\_rule\_expiration\_days) | Days to expire audit logs | `number` | `372` | no |
| <a name="input_lifecycle_rule_transition_days"></a> [lifecycle\_rule\_transition\_days](#input\_lifecycle\_rule\_transition\_days) | Days to trasit logs to different storage type | `number` | `30` | no |
| <a name="input_lifecycle_rule_transition_storage_class"></a> [lifecycle\_rule\_transition\_storage\_class](#input\_lifecycle\_rule\_transition\_storage\_class) | Transition target storage type see https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html#sc-compare | `string` | `"ONEZONE_IA"` | no |
| <a name="input_name"></a> [name](#input\_name) | Auditlog bucket name | `string` | n/a | yes |
| <a name="input_read_users"></a> [read\_users](#input\_read\_users) | Users with auditlog read access | `list(any)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | Auditlog region | `string` | n/a | yes |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | Athena auditlog table name | `string` | `"buckets"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auditlog_athena_database_name"></a> [auditlog\_athena\_database\_name](#output\_auditlog\_athena\_database\_name) | Auditlog Athena database name |
| <a name="output_auditlog_athena_table_name"></a> [auditlog\_athena\_table\_name](#output\_auditlog\_athena\_table\_name) | Auditlog Athena table name |
| <a name="output_bucket"></a> [bucket](#output\_bucket) | Auditlog bucket resource |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
