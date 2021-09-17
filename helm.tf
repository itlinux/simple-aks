provider "helm" {
  kubernetes {
    host = azurerm_kubernetes_cluster.cluster.kube_config[0].host
    client_key             = base64decode(azurerm_kubernetes_cluster.cluster.kube_config[0].client_key)
    client_certificate     = base64decode(azurerm_kubernetes_cluster.cluster.kube_config[0].client_certificate)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate)
  }
}

data "azurerm_resource_group" "rg" {
  name       = var.aks_cluster_name
  depends_on = [azurerm_kubernetes_cluster.cluster]
 }

resource "azurerm_kubernetes_cluster" "clusterhelm" {
  name       = "aks"
  location   = azurerm_resource_group.rg.location
  dns_prefix = "aks"

  resource_group_name = azurerm_resource_group.rg.name
  kubernetes_version  = var.k8s_version

  default_node_pool {
    name       = var.pool_name
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }
  tags = var.my_tags
}

resource "helm_release" "ingress" {
  name       = "ingress"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  #chart      = "stable/nginx-ingress"
  namespace  = "kube-system"
  timeout    = 1800
  version    = "7.6.21"

  set {
    name  = "rbac.create"
    value = "true"
  }
}
