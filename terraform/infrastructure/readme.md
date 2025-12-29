# Terraform Kubernetes Infrastructure (Yandex Cloud)

Проект создает инфраструктуру для Kubernetes кластера в Yandex Cloud: 1 master-ноду и 3 worker-ноды в зонах ru-central1-a/b/d с автоматической генерацией Ansible inventory.

## Архитектура

```
VPC (10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24)
├── k8s-master (ru-central1-a, 10.0.1.10)
├── k8s-node-a (ru-central1-a, 10.0.1.15)  
├── k8s-node-b (ru-central1-b, 10.0.2.15)
└── k8s-node-d (ru-central1-d, 10.0.3.15)
```

## Предварительные требования

- Yandex Cloud аккаунт с правами `editor`
- Terraform >= 1.8
- Ansible для развертывания K8s
- SSH-ключ: `~/.ssh/id_ed25519.pub`
- Service account ключ: `~/.authorized_key.json`

## Быстрый старт

```bash
# 1. Terraform инфраструктура
cd /mnt/c/Users/rlyst/Netology/devops/terraform/infrastructure
terraform init
terraform apply -auto-approve

# 2. Ansible развертывание K8s
cd ../../ansible
ansible-playbook -i inventories/hosts.yml install-master.yml
ansible-playbook -i inventories/hosts.yml install-node.yml

# 3. Проверка
export KUBECONFIG=./etc/kubernetes/admin.conf
kubectl get nodes
```

## Terraform outputs

После `terraform apply` доступны:

```
kubernetes_master_ssh    → ssh -l ubuntu <master-ip>
kubernetes_node_a_ssh    → ssh -l ubuntu <node-a-ip>
kubernetes_node_b_ssh    → ssh -l ubuntu <node-b-ip>  
kubernetes_node_d_ssh    → ssh -l ubuntu <node-d-ip>
```

## Ansible Inventory (автогенерация)

Terraform автоматически генерирует `../../ansible/inventories/hosts.yml` из шаблона `templates/inventory.tmpl`:

```yaml
all:
  children:
    K8S-master:
      hosts:
        k8s-server-1:
          ansible_host: <master-ip>
          ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
          ansible_python_interpreter: /usr/bin/python3.12
          ansible_user: ubuntu
    K8S-nodes:
      hosts:
        kubernetes-node-1:
          ansible_host: <node-a-ip>
          ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
          ansible_user: ubuntu
        kubernetes-node-2:
          ansible_host: <node-b-ip>
          ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
          ansible_user: ubuntu
        kubernetes-node-3:
          ansible_host: <node-d-ip>
          ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
          ansible_user: ubuntu
```

**Шаблон `templates/inventory.tmpl`:**
```yaml
all:
  children:
    K8S-master:
      hosts:
        ${join("\n        ", formatlist("k8s-server-%d:\n          ansible_host: %s\n          ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'\n          ansible_python_interpreter: /usr/bin/python3.12\n          ansible_user: ubuntu", 
          range(1, length(k8s_master_ips)+1), k8s_master_ips))}
    K8S-nodes:
      hosts:
        ${join("\n        ", formatlist("kubernetes-node-%d:\n          ansible_host: %s\n          ansible_ssh_common_args: '-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'\n          ansible_user: ubuntu", 
          range(1, length(k8s_node_ips)+1), k8s_node_ips))}
```

## Ansible развертывание

```bash
# Master
ansible-playbook -i inventories/hosts.yml install-master.yml

# Workers  
ansible-playbook -i inventories/hosts.yml install-node.yml
```

## Сетевые порты (Security Group)

| Порт | Описание | Доступ |
|------|----------|--------|
| 22 | SSH | 0.0.0.0/0 |
| 80/443 | HTTP/HTTPS | 0.0.0.0/0 |
| 6443 | Kubernetes API | 0.0.0.0/0 |
| 30443 | Dashboard | 0.0.0.0/0 |
| 30001 | Grafana/NodePort | 0.0.0.0/0 |

## Kubernetes настройка (после Ansible)

```bash
# На master после kubeadm init
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

## Очистка

```bash
# Ansible reset (при необходимости)
ansible-playbook -i inventories/hosts.yml reset.yml

# Terraform destroy  
cd /mnt/c/Users/rlyst/Netology/devops/terraform/infrastructure
terraform destroy -auto-approve
```

## Переменные окружения

| Переменная | Значение по умолчанию |
|------------|----------------------|
| `cloud_id` | b1g2uh898q9ekgq43tfq |
| `folder_id` | b1g22qi1cc8rq4avqgik |
| VM | ubuntu-2404-lts, 2CPU/4GB, 10GB disk |

## Зависимости

- [ter-yandex-vpc-module](https://github.com/DioRoman/ter-yandex-vpc-module.git?a7c4bbb)
- [ter-yandex-vm-module](https://github.com/DioRoman/ter-yandex-vm-module.git?ref=62484b2)

## Структура проекта

```
terraform/infrastructure/
├── locals.tf           # Локальные переменные, IP списки
├── network.tf          # VPC + Security Groups
├── vm.tf              # VM модули (master + nodes)
├── outputs.tf         # SSH команды, IP адреса
├── variables.tf       # Cloud/VPC/VM переменные
├── vars_modules.tf    # K8s master/node конфигурация
├── providers.tf       # Yandex provider + S3 backend
├── kubernetes.yml     # Cloud-init шаблон
└── templates/
    └── inventory.tmpl # Ansible inventory template
```