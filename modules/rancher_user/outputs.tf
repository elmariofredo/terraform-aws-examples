output "user" {
  value = rancher2_user.main
}

output "password" {
  value = random_password.main.result
}
