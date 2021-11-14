
resource "local_file" "kube_config" {
  content = yamlencode({
    "apiVersion" = "v1"

    "clusters" = [{
      "cluster" = {
        "certificate-authority-data" = "${aws_eks_cluster.main.certificate_authority[0].data}"

        "server" = "${aws_eks_cluster.main.endpoint}"
      }

      "name" = "kubernetes"
    }]

    "contexts" = [{
      "context" = {
        "cluster" = "kubernetes"

        "user" = "aws"
      }

      "name" = "aws"
    }]

    "current-context" = "aws"

    "kind" = "Config"

    "preferences" = {}

    "users" = [{
      "name" = "aws"
      "user" = {
        "exec" = {
          "apiVersion" = "client.authentication.k8s.io/v1alpha1"

          "args" = ["eks", "get-token", "--cluster-name", "${var.name}"]

          "command" = "aws"
        }
      }
    }]
  })
  filename = local.kube_config_path

  depends_on = [
    aws_eks_node_group.main,
  ]
}
