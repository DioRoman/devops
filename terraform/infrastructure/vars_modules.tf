variable "k8s_master" {
  type = list(
     object({ env_name = string, instance_name = list(string), instance_count = number, public_ip = bool, known_internal_ip = list(string), platform_id = string,
     cores = number, memory = number, disk_size = number, role= string }))
  default = ([ 
    { 
    env_name          = "k8s_master",
    instance_name     = ["k8s-master"], 
    instance_count    = 1, 
    public_ip         = true,
    known_internal_ip = ["10.0.1.10", "10.0.2.10", "10.0.3.10"],
    platform_id       = "standard-v3",
    cores             = 2,
    memory            = 4,
    disk_size         = 30,
    role              = "k8s_master"    
  }])
}

variable "k8s_node" {
  type = list(
     object({ env_name = string, instance_name = list(string), instance_count = number, public_ip = bool, known_internal_ip = list(string), platform_id = string,
     cores = number, memory = number, disk_size = number, role= string }))
  default = ([ 
    { 
    env_name          = "k8s_node",
    instance_name     = ["k8s-node-a","k8s-node-b","k8s-node-d"], 
    instance_count    = 1, 
    public_ip         = true,
    known_internal_ip = ["10.0.1.15", "10.0.2.15", "10.0.3.15"],
    platform_id       = "standard-v3",
    cores             = 2,
    memory            = 4,
    disk_size         = 10,
    role              = "k8s_node"    
  }])
}
