data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "aws_rds_cluster" "main" {
  engine             = var.engine
  engine_version     = var.engine_version
  availability_zones = data.aws_availability_zones.available.names
  database_name      = var.name
  master_username    = var.user
  master_password    = random_password.password.result
}

resource "aws_rds_cluster_instance" "main" {
  cluster_identifier  = aws_rds_cluster.main.id
  instance_class      = var.instance_class
  engine              = aws_rds_cluster.main.engine
  engine_version      = aws_rds_cluster.main.engine_version
  publicly_accessible = var.publicly_accessible
}

