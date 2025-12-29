
dio@ROMANPC:/mnt/c/Users/rlyst/Netology/devops/terraform/infrastructure$ terraform apply -auto-approve
data.template_file.kubernetes: Reading...
data.template_file.kubernetes: Read complete after 0s [id=b4f3656969b54e1a6bc1fa020db8be60aeefe710483fddec11b46b63c3733b5c]
data.yandex_compute_image.ubuntu: Reading...
data.yandex_compute_image.ubuntu: Read complete after 1s [id=fd8d6ui1a6greafrtud9]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.ansible_inventory will be created
  + resource "local_file" "ansible_inventory" {
      + content              = (known after apply)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./../../ansible/inventories/hosts.yml"
      + id                   = (known after apply)
    }

  # module.k8s_master.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-master"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_master"
          + "role" = "k8s_master"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-master"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.1.10"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_a.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-a"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-a"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.1.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_b.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-b"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-b"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-b"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.2.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_d.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-d"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-d"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-d"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.3.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.yandex_vpc.yandex_vpc_network.network will be created
  + resource "yandex_vpc_network" "network" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "k8s_master"
      + subnet_ids                = (known after apply)
    }

  # module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"] will be created
  + resource "yandex_vpc_security_group" "sg" {
      + created_at  = (known after apply)
      + description = "Security group for Kubernetes cluster"
      + folder_id   = (known after apply)
      + id          = (known after apply)
      + labels      = (known after apply)
      + name        = "k8s-security-group"
      + network_id  = (known after apply)
      + status      = (known after apply)

      + egress {
          + description       = "Allow outbound traffic"
          + from_port         = 0
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ANY"
          + to_port           = 65535
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }

      + ingress {
          + description       = "Full access"
          + from_port         = 0
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ANY"
          + to_port           = 65535
          + v4_cidr_blocks    = [
              + "10.0.0.0/8",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Grafana"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 30001
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "HTTP access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 80
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "HTTPS access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "ICMP"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ICMP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "10.0.0.0/8",
              + "91.204.150.0/24",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Kubernetes API access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 6443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Kubernetes Dashboard"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 30443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "SSH access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 22
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["1"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet ru-central1-a"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-a-1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["2"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet ru-central1-b"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-b-2"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["3"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet_ru-central1-d"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-d-3"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.3.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-d"
    }

Plan: 10 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + kubernetes_master_ips         = [
      + "10.0.1.10",
    ]
  + kubernetes_master_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_a_private_ips = [
      + "10.0.1.15",
    ]
  + kubernetes_node_a_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_b_private_ips = [
      + "10.0.2.15",
    ]
  + kubernetes_node_b_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_d_private_ips = [
      + "10.0.3.15",
    ]
  + kubernetes_node_d_ssh         = [
      + (known after apply),
    ]
module.yandex_vpc.yandex_vpc_network.network: Creating...
module.yandex_vpc.yandex_vpc_network.network: Creation complete after 2s [id=enpdv6su8ikq8uktandc]
module.yandex_vpc.yandex_vpc_subnet.subnets["2"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["3"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["1"]: Creating...
module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["2"]: Creation complete after 0s [id=e2lie9gp9pttu465s24t]
module.yandex_vpc.yandex_vpc_subnet.subnets["3"]: Creation complete after 1s [id=fl8s640c7asa535m40s9]
module.yandex_vpc.yandex_vpc_subnet.subnets["1"]: Creation complete after 1s [id=e9b66tt323mm3l0od7fa]
module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"]: Creation complete after 2s [id=enpbli12945umcchmu26]
module.k8s_node_b.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_d.yandex_compute_instance.vm[0]: Creating...
module.k8s_master.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_a.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Creation complete after 36s [id=fhmmn6g1eujs5quv99vo]
module.k8s_node_d.yandex_compute_instance.vm[0]: Creation complete after 38s [id=fv44dauudr6r7gcea32n]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m40s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m40s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Creation complete after 42s [id=epd3md55j413uakd2e1l]
module.k8s_node_a.yandex_compute_instance.vm[0]: Creation complete after 45s [id=fhm8j06f6m4ojp4or1ii]
local_file.ansible_inventory: Creating...
local_file.ansible_inventory: Creation complete after 0s [id=7eb0a802178f93961274c041b54d5640ae8c76c9]

Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_master_ips = [
  "10.0.1.10",
]
kubernetes_master_ssh = [
  "ssh -l ubuntu 89.169.140.156",
]
kubernetes_node_a_private_ips = [
  "10.0.1.15",
]
kubernetes_node_a_ssh = [
  "ssh -l ubuntu 130.193.49.226",
]
kubernetes_node_b_private_ips = [
  "10.0.2.15",
]
kubernetes_node_b_ssh = [
  "ssh -l ubuntu 84.201.161.233",
]
kubernetes_node_d_private_ips = [
  "10.0.3.15",
]
kubernetes_node_d_ssh = [
  "ssh -l ubuntu 51.250.44.235",
]dio@ROMANPC:/mnt/c/Users/rlyst/Netology/devops/terraform/infrastructure$ terraform apply -auto-approve
data.template_file.kubernetes: Reading...
data.template_file.kubernetes: Read complete after 0s [id=b4f3656969b54e1a6bc1fa020db8be60aeefe710483fddec11b46b63c3733b5c]
data.yandex_compute_image.ubuntu: Reading...
data.yandex_compute_image.ubuntu: Read complete after 1s [id=fd8d6ui1a6greafrtud9]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.ansible_inventory will be created
  + resource "local_file" "ansible_inventory" {
      + content              = (known after apply)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./../../ansible/inventories/hosts.yml"
      + id                   = (known after apply)
    }

  # module.k8s_master.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-master"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_master"
          + "role" = "k8s_master"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-master"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.1.10"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_a.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-a"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-a"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.1.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_b.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-b"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-b"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-b"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.2.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_d.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-d"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-d"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-d"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.3.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.yandex_vpc.yandex_vpc_network.network will be created
  + resource "yandex_vpc_network" "network" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "k8s_master"
      + subnet_ids                = (known after apply)
    }

  # module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"] will be created
  + resource "yandex_vpc_security_group" "sg" {
      + created_at  = (known after apply)
      + description = "Security group for Kubernetes cluster"
      + folder_id   = (known after apply)
      + id          = (known after apply)
      + labels      = (known after apply)
      + name        = "k8s-security-group"
      + network_id  = (known after apply)
      + status      = (known after apply)

      + egress {
          + description       = "Allow outbound traffic"
          + from_port         = 0
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ANY"
          + to_port           = 65535
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }

      + ingress {
          + description       = "Full access"
          + from_port         = 0
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ANY"
          + to_port           = 65535
          + v4_cidr_blocks    = [
              + "10.0.0.0/8",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Grafana"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 30001
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "HTTP access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 80
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "HTTPS access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "ICMP"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ICMP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "10.0.0.0/8",
              + "91.204.150.0/24",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Kubernetes API access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 6443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Kubernetes Dashboard"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 30443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "SSH access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 22
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["1"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet ru-central1-a"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-a-1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["2"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet ru-central1-b"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-b-2"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["3"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet_ru-central1-d"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-d-3"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.3.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-d"
    }

Plan: 10 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + kubernetes_master_ips         = [
      + "10.0.1.10",
    ]
  + kubernetes_master_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_a_private_ips = [
      + "10.0.1.15",
    ]
  + kubernetes_node_a_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_b_private_ips = [
      + "10.0.2.15",
    ]
  + kubernetes_node_b_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_d_private_ips = [
      + "10.0.3.15",
    ]
  + kubernetes_node_d_ssh         = [
      + (known after apply),
    ]
module.yandex_vpc.yandex_vpc_network.network: Creating...
module.yandex_vpc.yandex_vpc_network.network: Creation complete after 2s [id=enpdv6su8ikq8uktandc]
module.yandex_vpc.yandex_vpc_subnet.subnets["2"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["3"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["1"]: Creating...
module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["2"]: Creation complete after 0s [id=e2lie9gp9pttu465s24t]
module.yandex_vpc.yandex_vpc_subnet.subnets["3"]: Creation complete after 1s [id=fl8s640c7asa535m40s9]
module.yandex_vpc.yandex_vpc_subnet.subnets["1"]: Creation complete after 1s [id=e9b66tt323mm3l0od7fa]
module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"]: Creation complete after 2s [id=enpbli12945umcchmu26]
module.k8s_node_b.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_d.yandex_compute_instance.vm[0]: Creating...
module.k8s_master.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_a.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Creation complete after 36s [id=fhmmn6g1eujs5quv99vo]
module.k8s_node_d.yandex_compute_instance.vm[0]: Creation complete after 38s [id=fv44dauudr6r7gcea32n]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m40s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m40s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Creation complete after 42s [id=epd3md55j413uakd2e1l]
module.k8s_node_a.yandex_compute_instance.vm[0]: Creation complete after 45s [id=fhm8j06f6m4ojp4or1ii]
local_file.ansible_inventory: Creating...
local_file.ansible_inventory: Creation complete after 0s [id=7eb0a802178f93961274c041b54d5640ae8c76c9]

Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_master_ips = [
  "10.0.1.10",
]
kubernetes_master_ssh = [
  "ssh -l ubuntu 89.169.140.156",
]
kubernetes_node_a_private_ips = [
  "10.0.1.15",
]
kubernetes_node_a_ssh = [
  "ssh -l ubuntu 130.193.49.226",
]
kubernetes_node_b_private_ips = [
  "10.0.2.15",
]
kubernetes_node_b_ssh = [
  "ssh -l ubuntu 84.201.161.233",
]
kubernetes_node_d_private_ips = [
  "10.0.3.15",
]
kubernetes_node_d_ssh = [
  "ssh -l ubuntu 51.250.44.235",
]

dio@ROMANPC:/mnt/c/Users/rlyst/Netology/devops/terraform/infrastructure$ terraform apply -auto-approve
data.template_file.kubernetes: Reading...
data.template_file.kubernetes: Read complete after 0s [id=b4f3656969b54e1a6bc1fa020db8be60aeefe710483fddec11b46b63c3733b5c]
data.yandex_compute_image.ubuntu: Reading...
data.yandex_compute_image.ubuntu: Read complete after 1s [id=fd8d6ui1a6greafrtud9]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.ansible_inventory will be created
  + resource "local_file" "ansible_inventory" {
      + content              = (known after apply)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./../../ansible/inventories/hosts.yml"
      + id                   = (known after apply)
    }

  # module.k8s_master.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-master"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_master"
          + "role" = "k8s_master"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-master"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.1.10"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_a.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-a"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-a"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.1.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_b.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-b"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-b"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-b"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.2.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_d.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-d"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-d"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-d"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.3.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.yandex_vpc.yandex_vpc_network.network will be created
  + resource "yandex_vpc_network" "network" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "k8s_master"
      + subnet_ids                = (known after apply)
    }

  # module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"] will be created
  + resource "yandex_vpc_security_group" "sg" {
      + created_at  = (known after apply)
      + description = "Security group for Kubernetes cluster"
      + folder_id   = (known after apply)
      + id          = (known after apply)
      + labels      = (known after apply)
      + name        = "k8s-security-group"
      + network_id  = (known after apply)
      + status      = (known after apply)

      + egress {
          + description       = "Allow outbound traffic"
          + from_port         = 0
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ANY"
          + to_port           = 65535
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }

      + ingress {
          + description       = "Full access"
          + from_port         = 0
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ANY"
          + to_port           = 65535
          + v4_cidr_blocks    = [
              + "10.0.0.0/8",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Grafana"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 30001
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "HTTP access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 80
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "HTTPS access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "ICMP"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ICMP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "10.0.0.0/8",
              + "91.204.150.0/24",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Kubernetes API access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 6443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Kubernetes Dashboard"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 30443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "SSH access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 22
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["1"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet ru-central1-a"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-a-1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["2"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet ru-central1-b"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-b-2"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["3"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet_ru-central1-d"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-d-3"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.3.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-d"
    }

Plan: 10 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + kubernetes_master_ips         = [
      + "10.0.1.10",
    ]
  + kubernetes_master_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_a_private_ips = [
      + "10.0.1.15",
    ]
  + kubernetes_node_a_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_b_private_ips = [
      + "10.0.2.15",
    ]
  + kubernetes_node_b_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_d_private_ips = [
      + "10.0.3.15",
    ]
  + kubernetes_node_d_ssh         = [
      + (known after apply),
    ]
module.yandex_vpc.yandex_vpc_network.network: Creating...
module.yandex_vpc.yandex_vpc_network.network: Creation complete after 2s [id=enpdv6su8ikq8uktandc]
module.yandex_vpc.yandex_vpc_subnet.subnets["2"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["3"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["1"]: Creating...
module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["2"]: Creation complete after 0s [id=e2lie9gp9pttu465s24t]
module.yandex_vpc.yandex_vpc_subnet.subnets["3"]: Creation complete after 1s [id=fl8s640c7asa535m40s9]
module.yandex_vpc.yandex_vpc_subnet.subnets["1"]: Creation complete after 1s [id=e9b66tt323mm3l0od7fa]
module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"]: Creation complete after 2s [id=enpbli12945umcchmu26]
module.k8s_node_b.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_d.yandex_compute_instance.vm[0]: Creating...
module.k8s_master.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_a.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Creation complete after 36s [id=fhmmn6g1eujs5quv99vo]
module.k8s_node_d.yandex_compute_instance.vm[0]: Creation complete after 38s [id=fv44dauudr6r7gcea32n]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m40s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m40s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Creation complete after 42s [id=epd3md55j413uakd2e1l]
module.k8s_node_a.yandex_compute_instance.vm[0]: Creation complete after 45s [id=fhm8j06f6m4ojp4or1ii]
local_file.ansible_inventory: Creating...
local_file.ansible_inventory: Creation complete after 0s [id=7eb0a802178f93961274c041b54d5640ae8c76c9]

Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_master_ips = [
  "10.0.1.10",
]
kubernetes_master_ssh = [
  "ssh -l ubuntu 89.169.140.156",
]
kubernetes_node_a_private_ips = [
  "10.0.1.15",
]
kubernetes_node_a_ssh = [
  "ssh -l ubuntu 130.193.49.226",
]
kubernetes_node_b_private_ips = [
  "10.0.2.15",
]
kubernetes_node_b_ssh = [
  "ssh -l ubuntu 84.201.161.233",
]
kubernetes_node_d_private_ips = [
  "10.0.3.15",
]
kubernetes_node_d_ssh = [
  "ssh -l ubuntu 51.250.44.235",
]dio@ROMANPC:/mnt/c/Users/rlyst/Netology/devops/terraform/infrastructure$ terraform apply -auto-approve
data.template_file.kubernetes: Reading...
data.template_file.kubernetes: Read complete after 0s [id=b4f3656969b54e1a6bc1fa020db8be60aeefe710483fddec11b46b63c3733b5c]
data.yandex_compute_image.ubuntu: Reading...
data.yandex_compute_image.ubuntu: Read complete after 1s [id=fd8d6ui1a6greafrtud9]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.ansible_inventory will be created
  + resource "local_file" "ansible_inventory" {
      + content              = (known after apply)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./../../ansible/inventories/hosts.yml"
      + id                   = (known after apply)
    }

  # module.k8s_master.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-master"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_master"
          + "role" = "k8s_master"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-master"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.1.10"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_a.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-a"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-a"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.1.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_b.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-b"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-b"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-b"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.2.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.k8s_node_d.yandex_compute_instance.vm[0] will be created
  + resource "yandex_compute_instance" "vm" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hardware_generation       = (known after apply)
      + hostname                  = "k8s-node-d"
      + id                        = (known after apply)
      + labels                    = {
          + "env"  = "k8s_node"
          + "role" = "k8s_node"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "user-data"          = <<-EOT
                #cloud-config
                users:
                  - name: ubuntu
                    groups: sudo
                    shell: /bin/bash
                    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
                    ssh_authorized_keys:
                      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFoKft/gjdfCbQQlMmx0tQVpZUkduZTMY0RkgAny+toA roman@dio-mainpc


                package_update: true
                package_upgrade: true
                packages:
                  - mc
            EOT
        }
      + name                      = "k8s-node-d"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v3"
      + status                    = (known after apply)
      + zone                      = "ru-central1-d"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8d6ui1a6greafrtud9"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "10.0.3.15"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # module.yandex_vpc.yandex_vpc_network.network will be created
  + resource "yandex_vpc_network" "network" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "k8s_master"
      + subnet_ids                = (known after apply)
    }

  # module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"] will be created
  + resource "yandex_vpc_security_group" "sg" {
      + created_at  = (known after apply)
      + description = "Security group for Kubernetes cluster"
      + folder_id   = (known after apply)
      + id          = (known after apply)
      + labels      = (known after apply)
      + name        = "k8s-security-group"
      + network_id  = (known after apply)
      + status      = (known after apply)

      + egress {
          + description       = "Allow outbound traffic"
          + from_port         = 0
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ANY"
          + to_port           = 65535
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }

      + ingress {
          + description       = "Full access"
          + from_port         = 0
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ANY"
          + to_port           = 65535
          + v4_cidr_blocks    = [
              + "10.0.0.0/8",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Grafana"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 30001
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "HTTP access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 80
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "HTTPS access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "ICMP"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = -1
          + protocol          = "ICMP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "10.0.0.0/8",
              + "91.204.150.0/24",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Kubernetes API access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 6443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "Kubernetes Dashboard"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 30443
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
      + ingress {
          + description       = "SSH access"
          + from_port         = -1
          + id                = (known after apply)
          + labels            = (known after apply)
          + port              = 22
          + protocol          = "TCP"
          + to_port           = -1
          + v4_cidr_blocks    = [
              + "0.0.0.0/0",
            ]
          + v6_cidr_blocks    = []
            # (2 unchanged attributes hidden)
        }
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["1"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet ru-central1-a"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-a-1"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["2"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet ru-central1-b"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-b-2"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # module.yandex_vpc.yandex_vpc_subnet.subnets["3"] will be created
  + resource "yandex_vpc_subnet" "subnets" {
      + created_at     = (known after apply)
      + description    = "subnet_ru-central1-d"
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet_ru-central1-d-3"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.0.3.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-d"
    }

Plan: 10 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + kubernetes_master_ips         = [
      + "10.0.1.10",
    ]
  + kubernetes_master_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_a_private_ips = [
      + "10.0.1.15",
    ]
  + kubernetes_node_a_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_b_private_ips = [
      + "10.0.2.15",
    ]
  + kubernetes_node_b_ssh         = [
      + (known after apply),
    ]
  + kubernetes_node_d_private_ips = [
      + "10.0.3.15",
    ]
  + kubernetes_node_d_ssh         = [
      + (known after apply),
    ]
module.yandex_vpc.yandex_vpc_network.network: Creating...
module.yandex_vpc.yandex_vpc_network.network: Creation complete after 2s [id=enpdv6su8ikq8uktandc]
module.yandex_vpc.yandex_vpc_subnet.subnets["2"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["3"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["1"]: Creating...
module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"]: Creating...
module.yandex_vpc.yandex_vpc_subnet.subnets["2"]: Creation complete after 0s [id=e2lie9gp9pttu465s24t]
module.yandex_vpc.yandex_vpc_subnet.subnets["3"]: Creation complete after 1s [id=fl8s640c7asa535m40s9]
module.yandex_vpc.yandex_vpc_subnet.subnets["1"]: Creation complete after 1s [id=e9b66tt323mm3l0od7fa]
module.yandex_vpc.yandex_vpc_security_group.sg["k8s-security-group"]: Creation complete after 2s [id=enpbli12945umcchmu26]
module.k8s_node_b.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_d.yandex_compute_instance.vm[0]: Creating...
module.k8s_master.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_a.yandex_compute_instance.vm[0]: Creating...
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m10s elapsed]
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m20s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_d.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m30s elapsed]
module.k8s_master.yandex_compute_instance.vm[0]: Creation complete after 36s [id=fhmmn6g1eujs5quv99vo]
module.k8s_node_d.yandex_compute_instance.vm[0]: Creation complete after 38s [id=fv44dauudr6r7gcea32n]
module.k8s_node_b.yandex_compute_instance.vm[0]: Still creating... [00m40s elapsed]
module.k8s_node_a.yandex_compute_instance.vm[0]: Still creating... [00m40s elapsed]
module.k8s_node_b.yandex_compute_instance.vm[0]: Creation complete after 42s [id=epd3md55j413uakd2e1l]
module.k8s_node_a.yandex_compute_instance.vm[0]: Creation complete after 45s [id=fhm8j06f6m4ojp4or1ii]
local_file.ansible_inventory: Creating...
local_file.ansible_inventory: Creation complete after 0s [id=7eb0a802178f93961274c041b54d5640ae8c76c9]

Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_master_ips = [
  "10.0.1.10",
]
kubernetes_master_ssh = [
  "ssh -l ubuntu 89.169.140.156",
]
kubernetes_node_a_private_ips = [
  "10.0.1.15",
]
kubernetes_node_a_ssh = [
  "ssh -l ubuntu 130.193.49.226",
]
kubernetes_node_b_private_ips = [
  "10.0.2.15",
]
kubernetes_node_b_ssh = [
  "ssh -l ubuntu 84.201.161.233",
]
kubernetes_node_d_private_ips = [
  "10.0.3.15",
]
kubernetes_node_d_ssh = [
  "ssh -l ubuntu 51.250.44.235",
]
