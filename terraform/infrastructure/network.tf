# Создание сетей, подсетей и групп безопасности

module "yandex_vpc" {
source = "git::https://github.com/DioRoman/ter-yandex-vpc-module.git?ref=a7c4bbb"
  env_name = var.k8s_master[0].env_name
  subnets = [
    {
      name        = "subnet_ru-central1-a"
      cidr        = var.vpc_default_cidr[0]
      zone        = var.vpc_default_zone[0]
      description = "subnet ru-central1-a"
    },
    {
      name        = "subnet_ru-central1-b"
      cidr        = var.vpc_default_cidr[1]
      zone        = var.vpc_default_zone[1]
      description = "subnet ru-central1-b"
    },
    {
      name        = "subnet_ru-central1-d"
      cidr        = var.vpc_default_cidr[2]
      zone        = var.vpc_default_zone[2]
      description = "subnet_ru-central1-d"
    },
  ]
  
 security_groups = [
    {
      name        = "k8s-security-group"
      description = "Security group for Kubernetes cluster"
      ingress_rules = [
        {
          protocol    = "ANY"
          from_port   = 0
          to_port     = 65535
          description = "Full access"
          cidr_blocks = ["10.0.0.0/8"]
        },
        {
          protocol    = "TCP"
          port        = 80
          description = "HTTP access"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          protocol    = "TCP"
          port        = 443
          description = "HTTPS access"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          protocol    = "TCP"
          port        = 6443
          description = "Kubernetes API access"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          protocol    = "TCP"
          port        = 30443
          description = "Kubernetes Dashboard"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          protocol    = "TCP"
          port        = 22
          description = "SSH access"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          protocol    = "ICMP"
          description = "ICMP"
          cidr_blocks = ["10.0.0.0/8", "91.204.150.0/24"]
        }
      ],
      egress_rules = [
        {
          protocol    = "ANY"
          from_port   = 0
          to_port     = 65535
          description = "Allow outbound traffic"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  ]
}