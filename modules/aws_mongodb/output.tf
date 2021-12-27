output "endpoint" {
  value = aws_docdb_cluster_instance.main.endpoint
}

output "user" {
  value = var.user
}

output "password" {
  value = random_password.password.result
}

output "port" {
  value = aws_docdb_cluster_instance.main.port
}
