# Web outputs
output "kubernetes_master_ips" {
  description = "Private IP addresses of Web VMs"
  value       = module.k8s_master.internal_ips
}

output "kubernetes_master_ssh" {
  description = "SSH commands to connect to Web VMs"
  value = [
    for ip in module.k8s_master.external_ips : "ssh -l ubuntu ${ip}"
  ]
}

output "kubernetes_node_a_private_ips" {
  description = "Private IP addresses of Web VMs"
  value       = module.k8s_node_a.internal_ips
}

output "kubernetes_node_a_ssh" {
  description = "SSH commands to connect to Web VMs"
  value = [
    for ip in module.k8s_node_a.external_ips : "ssh -l ubuntu ${ip}"
  ]
}

output "kubernetes_node_b_private_ips" {
  description = "Private IP addresses of Web VMs"
  value       = module.k8s_node_b.internal_ips
}

output "kubernetes_node_b_ssh" {
  description = "SSH commands to connect to Web VMs"
  value = [
    for ip in module.k8s_node_b.external_ips : "ssh -l ubuntu ${ip}"
  ]
}


output "kubernetes_node_d_private_ips" {
  description = "Private IP addresses of Web VMs"
  value       = module.k8s_node_d.internal_ips
}

output "kubernetes_node_d_ssh" {
  description = "SSH commands to connect to Web VMs"
  value = [
    for ip in module.k8s_node_d.external_ips : "ssh -l ubuntu ${ip}"
  ]
}
