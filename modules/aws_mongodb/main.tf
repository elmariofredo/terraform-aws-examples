resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "aws_docdb_cluster" "main" {
  cluster_identifier      = var.name
  engine                  = var.engine
  engine_version          = var.engine_version
  master_username         = var.user
  master_password         = random_password.password.result
}

resource "aws_docdb_cluster_instance" "main" {
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = "db.r5.large"
}
