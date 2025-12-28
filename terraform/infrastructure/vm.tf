# Создание VM

module "k8s_master" {
  source              = "git::https://github.com/DioRoman/ter-yandex-vm-module.git?ref=62484b2"
  vm_name             = var.k8s_master[0].instance_name[0] 
  vm_count            = var.k8s_master[0].instance_count
  zone                = var.vpc_default_zone[0]
  subnet_ids          = [module.yandex_vpc.subnet_ids[0]]
  image_id            = data.yandex_compute_image.ubuntu.id
  platform_id         = var.k8s_master[0].platform_id
  cores               = var.k8s_master[0].cores
  memory              = var.k8s_master[0].memory
  disk_size           = var.k8s_master[0].disk_size 
  public_ip           = var.k8s_master[0].public_ip
  known_internal_ip   = var.k8s_master[0].known_internal_ip[0]
  security_group_ids  = [module.yandex_vpc.security_group_ids["k8s-security-group"]]
  
  labels = {
    env  = var.k8s_master[0].env_name
    role = var.k8s_master[0].role
  }

  metadata = {
    user-data = data.template_file.kubernetes.rendered
    serial-port-enable = local.serial-port-enable
  }  
}

module "k8s_node_a" {
  source              = "git::https://github.com/DioRoman/ter-yandex-vm-module.git?ref=62484b2"
  vm_name             = var.k8s_node[0].instance_name[0] 
  vm_count            = var.k8s_node[0].instance_count
  zone                = var.vpc_default_zone[0]
  subnet_ids          = [module.yandex_vpc.subnet_ids[0]]
  image_id            = data.yandex_compute_image.ubuntu.id
  platform_id         = var.k8s_node[0].platform_id
  cores               = var.k8s_node[0].cores
  memory              = var.k8s_node[0].memory
  disk_size           = var.k8s_node[0].disk_size 
  public_ip           = var.k8s_node[0].public_ip
  known_internal_ip   = var.k8s_node[0].known_internal_ip[0]
  security_group_ids  = [module.yandex_vpc.security_group_ids["k8s-security-group"]]

  labels = {
    env  = var.k8s_node[0].env_name
    role = var.k8s_node[0].role
  }

  metadata = {
    user-data = data.template_file.kubernetes.rendered
    serial-port-enable = local.serial-port-enable
  }  
}

module "k8s_node_b" {
  source              = "git::https://github.com/DioRoman/ter-yandex-vm-module.git?ref=62484b2"
  vm_name             = var.k8s_node[0].instance_name[1] 
  vm_count            = var.k8s_node[0].instance_count
  zone                = var.vpc_default_zone[1]
  subnet_ids          = [module.yandex_vpc.subnet_ids[1]]
  image_id            = data.yandex_compute_image.ubuntu.id
  platform_id         = var.k8s_node[0].platform_id
  cores               = var.k8s_node[0].cores
  memory              = var.k8s_node[0].memory
  disk_size           = var.k8s_node[0].disk_size 
  public_ip           = var.k8s_node[0].public_ip
  known_internal_ip   = var.k8s_node[0].known_internal_ip[1]
  security_group_ids  = [module.yandex_vpc.security_group_ids["k8s-security-group"]]

  labels = {
    env  = var.k8s_node[0].env_name
    role = var.k8s_node[0].role
  }

  metadata = {
    user-data = data.template_file.kubernetes.rendered
    serial-port-enable = local.serial-port-enable
  }  
}


module "k8s_node_d" {
  source              = "git::https://github.com/DioRoman/ter-yandex-vm-module.git?ref=62484b2"
  vm_name             = var.k8s_node[0].instance_name[2] 
  vm_count            = var.k8s_node[0].instance_count
  zone                = var.vpc_default_zone[2]
  subnet_ids          = [module.yandex_vpc.subnet_ids[2]]
  image_id            = data.yandex_compute_image.ubuntu.id
  platform_id         = var.k8s_node[0].platform_id
  cores               = var.k8s_node[0].cores
  memory              = var.k8s_node[0].memory
  disk_size           = var.k8s_node[0].disk_size 
  public_ip           = var.k8s_node[0].public_ip
  known_internal_ip   = var.k8s_node[0].known_internal_ip[2]
  security_group_ids  = [module.yandex_vpc.security_group_ids["k8s-security-group"]]

  labels = {
    env  = var.k8s_node[0].env_name
    role = var.k8s_node[0].role
  }

  metadata = {
    user-data = data.template_file.kubernetes.rendered
    serial-port-enable = local.serial-port-enable
  }  
}

# Инициализация 
data "template_file" "kubernetes" {
  template = file("./kubernetes.yml")
    vars = {
    ssh_public_key     = file(var.vm_ssh_root_key)
  }
}

# Получение id образа Ubuntu
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tmpl", {
    k8s_master_ips = local.k8s_master_ips
    k8s_node_ips   = local.k8s_node_ips
  })
  
  filename = "${path.module}/../../ansible/inventories/hosts.yml"
  
  depends_on = [
    module.k8s_master,
    module.k8s_node_a,
    module.k8s_node_b, 
    module.k8s_node_d
  ]
}