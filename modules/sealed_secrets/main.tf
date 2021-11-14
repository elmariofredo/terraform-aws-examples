resource "helm_release" "sealed_secrets" {
  name             = "sealed-secrets"
  namespace        = var.namespace
  create_namespace = "true"
  repository       = "https://bitnami-labs.github.io/sealed-secrets"
  chart            = "sealed-secrets"

  // Values: https://github.com/bitnami-labs/sealed-secrets/blob/main/helm/sealed-secrets/values.yaml

}
