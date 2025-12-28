locals {
    serial-port-enable = 1
}

locals {
  k8s_master_ips = flatten([
    module.k8s_master.external_ips,
    # добавьте другие master-группы если есть
  ])
  
  k8s_node_ips = flatten([
    module.k8s_node_a.external_ips,
    module.k8s_node_b.external_ips, 
    module.k8s_node_d.external_ips
  ])
}