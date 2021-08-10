# Create aws bucket with sane defaults

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.53.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_group.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group.write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_membership.write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy.read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_iam_group_policy.write](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | Bucket ACL | `string` | `"private"` | no |
| <a name="input_auditlog_bucket_name"></a> [auditlog\_bucket\_name](#input\_auditlog\_bucket\_name) | Bucket name for storing access logs | `string` | n/a | yes |
| <a name="input_aws_kms_key_buckets_arn"></a> [aws\_kms\_key\_buckets\_arn](#input\_aws\_kms\_key\_buckets\_arn) | KMS key ARN for buckets | `string` | `null` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Bucket name | `string` | n/a | yes |
| <a name="input_lifecycle_expiration_days"></a> [lifecycle\_expiration\_days](#input\_lifecycle\_expiration\_days) | Bucket object expiration days | `number` | `null` | no |
| <a name="input_lifecycle_noncurrent_version_expiration_days"></a> [lifecycle\_noncurrent\_version\_expiration\_days](#input\_lifecycle\_noncurrent\_version\_expiration\_days) | Bucket object expiration days | `number` | `30` | no |
| <a name="input_lifecycle_rule_transition_days"></a> [lifecycle\_rule\_transition\_days](#input\_lifecycle\_rule\_transition\_days) | Days to trasit logs to different storage type | `number` | `30` | no |
| <a name="input_lifecycle_rule_transition_storage_class"></a> [lifecycle\_rule\_transition\_storage\_class](#input\_lifecycle\_rule\_transition\_storage\_class) | Transition target storage type see https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html#sc-compare | `string` | `"ONEZONE_IA"` | no |
| <a name="input_name"></a> [name](#input\_name) | Bucket description [Tags] | `string` | n/a | yes |
| <a name="input_read_users"></a> [read\_users](#input\_read\_users) | Users with read access | `list(any)` | `[]` | no |
| <a name="input_sse_algorithm"></a> [sse\_algorithm](#input\_sse\_algorithm) | Serve side encryption algorithm | `string` | `"aws:kms"` | no |
| <a name="input_write_users"></a> [write\_users](#input\_write\_users) | Users with write access | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | Bucket resource |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
