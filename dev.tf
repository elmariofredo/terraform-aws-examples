# module "dev" {
#   source = "./env/dev"

#   email = local.email
# }

# output "dev_rancher_url" {
#   value = module.dev.rancher_url
# }

# output "dev_rancher_user" {
#   value = module.dev.rancher_user
# }

# output "dev_rancher_password" {
#   value = module.dev.rancher_password
#   sensitive = true
# }

# output "dev_rancher_password_extract" {
#   value = "terraform output -json | jq -r .dev_rancher_password.value"
# }

# output "dev_argo_url" {
#   value = module.dev.argo_url
# }

# output "dev_argo_user" {
#   value = module.dev.argo_user
#   sensitive = true
# }
# output "dev_argo_password" {
#   value = module.dev.argo_password
#   sensitive = true
# }

# output "dev_argo_password_extract" {
#   value = "terraform output -json | jq -r .dev_argo_password.value"
# }

# output "dev_db_endpoint" {
#   value = module.dev.db_endpoint
# }

# output "dev_db_user" {
#   value = module.dev.db_user
# }

# output "dev_db_password" {
#   value = module.dev.db_password
#   sensitive = true
# }

# output "dev_db_port" {
#   value = module.dev.db_port
# }

# output "dev_redis_endpoint" {
#   value = module.dev.redis_endpoint
# }

# output "dev_elasticsearch_endpoint" {
#   value = module.dev.elasticsearch_endpoint
# }

# output "dev_mq_endpoint" {
#   value = module.dev.mq_endpoint
# }

# output "dev_mq_user" {
#   value = module.dev.mq_user
# }

# output "dev_mq_password" {
#   value = module.dev.mq_password
#   sensitive = true
# }
