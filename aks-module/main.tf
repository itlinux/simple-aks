provider "azurerm" {
  features {
  }
}

provider "helm" {
  #version = "1.2.2"
  kubernetes {
    host = azurerm_kubernetes_cluster.cluster.kube_config[0].host

    client_key             = base64decode(azurerm_kubernetes_cluster.cluster.kube_config[0].client_key)
    client_certificate     = base64decode(azurerm_kubernetes_cluster.cluster.kube_config[0].client_certificate)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate)
    load_config_file       = false
  }
}


resource "azurerm_resource_group" "rg" {
  name     = var.name_cluster_rg
  location = var.location
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name       = "aks-cluster-${var.name_cluster}"
  location   = azurerm_resource_group.rg.location
  dns_prefix = var.dns_prefix

  resource_group_name = azurerm_resource_group.rg.name
  kubernetes_version  =  var.k8s_version

  default_node_pool {
    name       = var.pool_name
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "helm_release" "ingress" {
  name  = "ingress"
  chart = "stable/nginx-ingress"

  set {
    name  = "rbac.create"
    value = "true"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.cluster.kube_config_raw
}
