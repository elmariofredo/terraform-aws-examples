data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_elasticache_replication_group" "main" {
  automatic_failover_enabled    = true
  availability_zones            = slice(data.aws_availability_zones.available.names, 0, var.number_cache_clusters)
  replication_group_id          = var.name
  replication_group_description = var.name
  node_type                     = var.instance_type
  number_cache_clusters         = var.number_cache_clusters
  parameter_group_name          = aws_elasticache_parameter_group.main.name
  port                          = 6379

}


resource "aws_elasticache_parameter_group" "main" {
  name   = var.name
  family = var.family
}
