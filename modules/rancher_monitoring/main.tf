# resource "rancher2_catalog_v2" "rancher_charts_master" {
#   cluster_id = var.cluster_id
#   name       = "rancher-charts-master"
#   git_repo   = "https://github.com/rancher/charts"
#   git_branch = "dev-v2.6" # https://github.com/rancher/rancher/issues/33014#issuecomment-893067995
# }


resource "rancher2_app_v2" "crd" {
  cluster_id    = var.cluster_id
  name          = "rancher-monitoring-crd"
  namespace     = "cattle-monitoring-system"
  repo_name     = "rancher-charts" # rancher2_catalog_v2.rancher_charts_master.name
  chart_name    = "rancher-monitoring-crd"
  chart_version = "100.0.0+up16.6.0"
}

resource "rancher2_app_v2" "main" {
  cluster_id    = var.cluster_id
  name          = "rancher-monitoring"
  namespace     = "cattle-monitoring-system"
  repo_name     = "rancher-charts" # rancher2_catalog_v2.rancher_charts_master.name
  chart_name    = "rancher-monitoring"
  chart_version = "100.0.0+up16.6.0"

  depends_on = [
    rancher2_app_v2.crd,
  ]
}
