variable  location  {
  default = "West US 2"
}

variable "my_tags" {
    type = map
    default = {
        owner : "Remo Mattei"
        Name: "Remo Mattei",
        department: "F5 SA"
        team: "SA"
        app: "AKS"
        type  : "AKS Deployment"
        env: "Demo"
  }
}

variable  dns_prefix {
  description = "DNS Prefix, it does have a charather limitation"
  default =  "rmaks"
}

variable pool_name {
  description = "Pool Name does have a charather limitation"
  default = "rmaks"
}

variable node_count {
  description = "Node Count default is 1"
  default = "1"
}

variable vm_size {
  description = "Size of the VM to use for the Kubernetes"
  default =  "Standard_D2s_v3"
}
variable aks_cluster_name {
  default = "aks-cluster-remo"
}

variable name_cluster_rg {
  default = "remo-aks-cluster"
  description = "RG name"
}
variable name_cluster {
  description = "name of the cluster"
  default = "aks"
}
variable k8s_version {
  description = "K8s version to use"
  default = "1.19.7"
}