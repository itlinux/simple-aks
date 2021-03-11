  variable location {
    #default    = "West US 2"
    description = "Which region for Azure"
  }
  variable name_cluster_rg {
    #default = "akscluster"
    description = "RG name"
  }
  variable name_cluster {
    description = "name of the cluster"
    #default = "aks"
  }
  variable k8s_version {
    description = "K8s version to use"
    #default = "1.19.7"
  }
  variable dns_prefix {
    description = "DNS Prefix"
    #default = "aksrm"
  }
  variable pool_name {
    description = "Pool Name"
    #default = "aks_pool"
  }
  variable node_count {
    description = "Node Count default is 1"
    #default = "1"
  }
  variable vm_size {
    description = "Size of the VM to use for the Kubernetes"
    #default     = "Standard_D2s_v3"
  }
