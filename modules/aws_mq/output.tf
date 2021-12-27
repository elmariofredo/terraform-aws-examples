output "endpoint" {
  value = aws_mq_broker.main.instances.0.endpoints.0
}

output "user" {
  value = var.user
}

output "password" {
  value     = random_password.password.result
  sensitive = true
}
