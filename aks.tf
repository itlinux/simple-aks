provider "kubernetes" {
  config_path = "./config-aks"
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.aks_cluster_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name       = "aks_cluster"
  location   = azurerm_resource_group.rg.location
  dns_prefix = var.dns_prefix

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
