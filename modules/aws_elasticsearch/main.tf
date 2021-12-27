resource "aws_elasticsearch_domain" "main" {
  domain_name           = var.name
  elasticsearch_version = var.engine_version

  cluster_config {
    instance_type = var.instance_type
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.volume_size
  }

}
