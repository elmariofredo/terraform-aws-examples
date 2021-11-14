# resource "aws_elasticsearch_domain" "logs" {
#   domain_name           = "logs"
#   elasticsearch_version = "7.10"

#   cluster_config {
#     instance_type = "r4.large.elasticsearch"
#   }

#   ebs_options {
#     ebs_enabled = true
#     volume_size = 10
#   }

#   tags = {
#     Domain = "LogsDomain"
#   }
# }


# data "aws_availability_zones" "available" {
#   state = "available"
# }

# resource "random_password" "db_password" {
#   length           = 16
#   special          = true
#   override_special = "_"
# }

# # aurora-postgresql
# resource "aws_rds_cluster" "postgresql" {
#   cluster_identifier      = "aurora-cluster-dev"
#   engine                  = "aurora-postgresql"
#   availability_zones      = data.aws_availability_zones.available.names
#   database_name           = "deso"
#   master_username         = "deso"
#   master_password         = random_password.db_password.result
#   backup_retention_period = 5
#   preferred_backup_window = "07:00-09:00"
# }

# resource "aws_docdb_cluster" "dev" {
#   cluster_identifier      = "dev"
#   engine                  = "docdb"
#   master_username         = "deso"
#   master_password         = random_password.db_password.result
#   backup_retention_period = 5
#   preferred_backup_window = "07:00-09:00"
#   skip_final_snapshot     = true
# }

# resource "aws_elasticache_cluster" "dev" {
#   cluster_id           = "cluster-dev"
#   engine               = "memcached"
#   node_type            = "cache.m4.large"
#   num_cache_nodes      = 2
#   parameter_group_name = aws_elasticache_parameter_group.default.name
#   port                 = 11211
# }

# resource "aws_elasticache_parameter_group" "default" {
#   name   = "cache-params"
#   family = "memcached1.6"

#   # parameter {
#   #   name  = "activerehashing"
#   #   value = "yes"
#   # }

#   # parameter {
#   #   name  = "min-slaves-to-write"
#   #   value = "2"
#   # }
# }

# resource "aws_mq_configuration" "dev" {
#   description    = "Dev Configuration"
#   name           = "dev"
#   engine_type    = "ActiveMQ"
#   engine_version = "5.15.0"

#   data = <<DATA
# <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
# <broker xmlns="http://activemq.apache.org/schema/core">
#   <plugins>
#     <forcePersistencyModeBrokerPlugin persistenceFlag="true"/>
#     <statisticsBrokerPlugin/>
#     <timeStampingBrokerPlugin ttlCeiling="86400000" zeroExpirationOverride="86400000"/>
#   </plugins>
# </broker>
# DATA
# }

# resource "aws_security_group" "mq" {
#   name        = "dummy"
#   description = "dummy"
#   vpc_id      = local.vpc_id

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

# }

# resource "aws_mq_broker" "dev" {
#   broker_name = "dev"

#   configuration {
#     id       = aws_mq_configuration.dev.id
#     revision = aws_mq_configuration.dev.latest_revision
#   }

#   engine_type        = "ActiveMQ"
#   engine_version     = "5.15.9"
#   host_instance_type = "mq.t2.micro"
#   security_groups    = [aws_security_group.mq.id]

#   user {
#     username = "Deso"
#     password = random_password.db_password.result
#   }
# }
