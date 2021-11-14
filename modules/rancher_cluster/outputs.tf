output "id" {
  value = rancher2_cluster.main.id
}

output "import_manifest_url" {
  value = rancher2_cluster.main.cluster_registration_token[0].manifest_url
}
