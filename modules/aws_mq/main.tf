# resource "aws_mq_configuration" "main" {
#   description    = var.name
#   name           = var.name
#   engine_type    = var.engine_type
#   engine_version = var.engine_version

#   # See https://docs.aws.amazon.com/amazon-mq/latest/developer-guide/amazon-mq-broker-configuration-parameters.html
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

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_"
}

resource "aws_mq_broker" "main" {
  broker_name = var.name

  # configuration {
  #   id       = aws_mq_configuration.main.id
  #   revision = aws_mq_configuration.main.latest_revision
  # }

  engine_type    = var.engine_type
  engine_version = var.engine_version
  host_instance_type = var.instance_type

  user {
    username = var.user
    password = random_password.password.result
  }
}
