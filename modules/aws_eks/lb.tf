# resource "helm_release" "lb_controller" {
#   name       = "aws-load-balancer-controller"
#   chart      = "aws-load-balancer-controller"
#   repository = "https://aws.github.io/eks-charts"
#   version    = "1.3.2"
#   namespace  = "kube-system"

#   # see https://github.com/aws/eks-charts/tree/master/stable/aws-load-balancer-controller#configuration
#   values = [
#     yamlencode({
#       clusterName = var.name
#       rbac = {
#         create = true
#       }
#       serviceAccount = {
#         create = true
#         name = var.lb_service_account_name
#         annotations = {
#           "eks.amazonaws.com/role-arn" = aws_iam_role.lb_controller.arn
#         }
#       }
#     }),
#     yamlencode(var.lb_values)
#   ]

#   depends_on = [
#     local_file.kube_config
#   ]
# }
