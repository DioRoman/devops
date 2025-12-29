# Kubernetes Cluster Deployment with Ansible

Полностью автоматизированное развертывание однохозяйского кластера Kubernetes (1 master + N worker nodes) на Ubuntu 24.04 с использованием Ansible. Включает установку Kubernetes Dashboard, Grafana, Prometheus и Nginx reverse proxy.

---

## 📋 Содержание

- [Требования](#требования)
- [Структура проекта](#структура-проекта)
- [Подготовка окружения](#подготовка-окружения)
- [Использование плейбуков](#использование-плейбуков)
- [Переменные конфигурации](#переменные-конфигурации)
- [Процесс развертывания](#процесс-развертывания)
- [Доступ к сервисам](#доступ-к-сервисам)
- [Диагностика](#диагностика)
- [Очистка и удаление](#очистка-и-удаление)

---

## Требования

### Инструменты на локальной машине

- **Ansible** >= 2.9
  ```bash
  pip install ansible
  ```
- **kubectl** (для управления кластером)
  ```bash
  # macOS
  brew install kubectl
  # Linux
  sudo apt-get install -y kubectl
  ```
- **SSH ключи** для подключения к узлам (по умолчанию без пароля)

### Серверы (Ubuntu 24.04)

- **Master node**: минимум 2 vCPU, 4 GB RAM
- **Worker nodes**: минимум 2 vCPU, 4 GB RAM каждый
- **Сетевой доступ**: все узлы должны видеть друг друга по сети
- **Интернет**: для скачивания образов и компонентов

### Предварительная настройка

Все узлы должны быть доступны по SSH:

```bash
# Проверка SSH доступа
ssh -i ~/.ssh/id_rsa ubuntu@<MASTER_IP>
ssh -i ~/.ssh/id_rsa ubuntu@<NODE_IP>
```

---

## Структура проекта

```
ansible/
├── README.md                              # Этот файл
├── inventories/
│   └── hosts.yml                         # Инвентарь с IP адресами узлов
├── group_vars/
│   └── all/
│       └── vars.yml                      # Глобальные переменные
├── secrets/
│   └── kubeadm-join.yml                 # Генерируется автоматически (токены)
├── templates/
│   └── k8s-proxy.conf.j2                # Jinja2 шаблон для Nginx
├── install-master.yml                    # Плейбук: инициализация Master
├── install-node.yml                      # Плейбук: присоединение Worker узлов
├── install-nginx-proxy.yml               # Плейбук: Nginx reverse proxy
└── install-dashboard-monitoring.yml      # Плейбук: Dashboard + Monitoring
```

---

## Подготовка окружения

### 1. Клонирование или подготовка плейбуков

```bash
mkdir -p ~/ansible && cd ~/ansible
# Скопируйте все файлы из архива в текущую директорию
```

### 2. Обновление инвентаря (hosts.yml) 

Формируется автоматически через Terraform

Если нет то:

Отредактируйте `inventories/hosts.yml` с реальными IP адресами:

```yaml
all:
  children:
    K8S-master:
      hosts:
        k8s-server-1:
          ansible_host: 192.168.1.100          # IP мастера
          ansible_user: ubuntu
          ansible_python_interpreter: /usr/bin/python3.12
    K8S-nodes:
      hosts:
        kubernetes-node-1:
          ansible_host: 192.168.1.101           # IP worker-1
          ansible_user: ubuntu
        kubernetes-node-2:
          ansible_host: 192.168.1.102           # IP worker-2
          ansible_user: ubuntu
```

### 3. Проверка подключения Ansible

```bash
# Проверка доступности всех узлов
ansible all -i inventories/hosts.yml -m ping

# Вывод:
# k8s-server-1 | SUCCESS => {
#    "ping": "pong"
# }
```

### 4. Создание директории secrets (если не существует)

```bash
mkdir -p secrets
touch secrets/kubeadm-join.yml
```

### 5. Генерация SSH ключей (если необходимо)

```bash
# На локальной машине, если ключей еще нет
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""

# Копирование публичного ключа на узлы
ssh-copy-id -i ~/.ssh/id_rsa.pub ubuntu@<MASTER_IP>
ssh-copy-id -i ~/.ssh/id_rsa.pub ubuntu@<NODE_IP>
```

---

## Использование плейбуков

### Быстрый запуск (рекомендуется)

Выполните все плейбуки по порядку:

```bash
# 1. Развертывание Master node
ansible-playbook -i inventories/hosts.yml install-master.yml -v

# 2. Развертывание Worker nodes
ansible-playbook -i inventories/hosts.yml install-node.yml -v

# 3. Установка Nginx proxy
ansible-playbook -i inventories/hosts.yml install-nginx-proxy.yml -v

# 4. Установка Dashboard + Monitoring
ansible-playbook -i inventories/hosts.yml install-dashboard-monitoring.yml -v

# 5. Подключение локальной машины к кластеру
ansible-playbook -i inventories/hosts.yml localhost-connect-k8s-cluster.yml -v
```

### Пошаговое выполнение

#### Шаг 1: Инициализация Master узла

```bash
ansible-playbook -i inventories/hosts.yml install-master.yml
```

**Что происходит:**
- Установка containerd
- Установка kubelet, kubeadm, kubectl v1.34
- Инициализация Kubernetes кластера с Calico CNI
- Создание токена для присоединения worker узлов
- Сохранение команды join в `secrets/kubeadm-join.yml`

**Проверка:**
```bash
# На мастере
kubectl get nodes
kubectl get pods -A
```

#### Шаг 2: Присоединение Worker узлов

```bash
ansible-playbook -i inventories/hosts.yml install-node.yml
```

**Что происходит:**
- Установка containerd
- Установка kubelet, kubeadm, kubectl
- Присоединение узлов к кластеру (kubeadm join)
- Проверка статуса узлов

**Проверка:**
```bash
kubectl get nodes
# Все узлы должны быть в состоянии "Ready"
```

#### Шаг 3: Nginx Reverse Proxy (опционально)

```bash
ansible-playbook -i inventories/hosts.yml install-nginx-proxy.yml
```

**Что происходит:**
- Установка и настройка Nginx на Master узле
- Настройка проксирования на NodePort сервисы:
  - `/` → dio-app (NodePort 30080)
  - `/grafana/` → Grafana (NodePort 30001)
  - `/dashboard/` → K8s Dashboard (NodePort 30443)

**Проверка:**
```bash
curl http://<MASTER_IP>/
nginx -t  # на мастере
```
В результате dio-app будет доступен на 80 порту

#### Шаг 4: Kubernetes Dashboard + Monitoring

```bash
ansible-playbook -i inventories/hosts.yml install-dashboard-monitoring.yml
```

**Что происходит:**
- Установка Kubernetes Dashboard через Helm
- Установка Prometheus Stack (Prometheus, Grafana, Alertmanager)
- Создание ServiceAccount для Dashboard
- Получение токена доступа
- Настройка NodePort сервисов

**Вывод плейбука содержит:**
```
GRAFANA (доступна извне):
  URL: http://<MASTER_IP>:30001
  Логин: admin
  Пароль: prom-operator

KUBERNETES DASHBOARD (доступен извне):
  URL: https://<MASTER_IP>:30443
  ТОКЕН: [скопируйте целиком одной строкой]
```

#### Шаг 5: Подключение локальной машины

```bash
ansible-playbook -i inventories/hosts.yml localhost-connect-k8s-cluster.yml
```

**Что происходит:**
- Копирование kubeconfig с мастера на локальную машину
- Добавление записи в `/etc/hosts`
- Добавление алиасов kubectl в `~/.bashrc`
- Проверка доступности кластера

**После выполнения:**
```bash
source ~/.bashrc
k8s-nodes      # alias для kubectl get nodes -o wide
k8s-pods       # alias для kubectl get pods -A
k8s-all        # alias для kubectl get all -A
```

---

## Переменные конфигурации

### Основные переменные (group_vars/all/vars.yml)

| Переменная | Значение | Описание |
|---|---|---|
| `ansible_user` | ubuntu | Пользователь для SSH подключения |
| `ansible_python_interpreter` | /usr/bin/python3.12 | Интерпретатор Python |
| `kube_control_plane_hostname` | k8s-master | Имя мастера в сети |
| `kube_control_plane_ip` | 10.0.1.10 | IP адрес мастера (для /etc/hosts) |
| `pod_network_cidr` | 192.168.0.0/16 | CIDR сеть для подов (Calico) |
| `dashboard_namespace` | kubernetes-dashboard | Namespace для Dashboard |
| `dashboard_nodeport` | 30443 | NodePort для Dashboard (HTTPS) |
| `monitoring_namespace` | monitoring | Namespace для Prometheus/Grafana |
| `grafana_nodeport` | 30001 | NodePort для Grafana |
| `nginx_proxy_port` | 80 | Порт Nginx |

### Изменение переменных

```bash
# Отредактируйте групповые переменные
nano group_vars/all/vars.yml

# Или передайте переменные в командной строке
ansible-playbook install-master.yml \
  -e "kube_control_plane_ip=10.0.2.100" \
  -e "pod_network_cidr=10.244.0.0/16"
```

---

## Процесс развертывания

### Визуальный процесс развертывания

```
┌─────────────────────────────────────────────────────┐
│  1. install-master.yml                              │
│  ├─ Установка containerd                            │
│  ├─ Установка K8s компонентов (v1.34)              │
│  ├─ kubeadm init                                    │
│  ├─ Установка Calico CNI                           │
│  └─ Создание токена join → secrets/kubeadm-join.yml│
└────────────────────┬────────────────────────────────┘
                     │
        ┌────────────▼────────────┐
        │ 2. install-node.yml     │
        │ ├─ Установка containerd │
        │ ├─ Установка K8s        │
        │ └─ kubeadm join         │
        │ (для каждого worker)    │
        └────────────┬────────────┘
                     │
        ┌────────────▼──────────────────┐
        │ 3. install-nginx-proxy.yml    │
        │ ├─ Установка Nginx            │
        │ └─ Конфигурация прокси        │
        └────────────┬──────────────────┘
                     │
        ┌────────────▼────────────────────────────┐
        │ 4. install-dashboard-monitoring.yml    │
        │ ├─ K8s Dashboard (Helm)                 │
        │ ├─ Prometheus Stack (Helm)              │
        │ └─ ServiceAccount + RBAC                │
        └────────────┬────────────────────────────┘
                     │
        ┌────────────▼─────────────────────────┐
        │ 5. localhost-connect-k8s-cluster.yml │
        │ ├─ Копирование kubeconfig            │
        │ ├─ /etc/hosts                        │
        │ └─ ~/.bashrc алиасы                  │
        └────────────┬─────────────────────────┘
                     │
                ✓ ГОТОВО!
```

### Типичное время выполнения

| Плейбук | Время | Примечания |
|---|---|---|
| install-master.yml | 5 мин | Включает загрузку образов |
| install-node.yml | 5 мин за узел | Зависит от количества worker |
| install-nginx-proxy.yml | 2-3 мин | Быстрая установка |
| install-dashboard-monitoring.yml | 5 мин | Helm чарты скачиваются |
| localhost-connect-k8s-cluster.yml | 1-2 мин | Локальная конфигурация |

**Итого:** ~15-20 минут для кластера 1 master + 3 worker

---

## Доступ к сервисам

### Kubernetes Dashboard

**Прямой доступ на NodePort**

```bash
# URL
https://<MASTER_IP>:30443

# Игнорируйте предупреждение о сертификате (self-signed)
# Скопируйте токен из вывода плейбука
```

### Grafana

**Прямой доступ**

```bash
# URL
http://<MASTER_IP>:30001

Стандартный логин и пароль
# Логин: admin
# Пароль: prom-operator
```

### Приложение (DIO App)

```bash
# Через Nginx proxy
http://<MASTER_IP>/
```

### Локальная работа с kubectl

```bash
# После выполнения localhost-connect-k8s-cluster.yml
export KUBECONFIG=~/.kube/config

# Список узлов
kubectl get nodes -o wide

# Список всех подов
kubectl get pods -A

# Логи приложения
kubectl logs -f -n default deployment/<APP_NAME>

# Открыть shell в поде
kubectl exec -it -n default <POD_NAME> -- /bin/bash
```

---

## Диагностика

### Проблема: Узлы не переходят в состояние "Ready"

```bash
# 1. Проверка статуса узлов на мастере
kubectl get nodes
kubectl describe node <NODE_NAME>

# 2. Проверка логов kubelet на worker узле
ssh ubuntu@<NODE_IP>
journalctl -u kubelet -n 50

# 3. Проверка containerd
sudo systemctl status containerd
sudo containerd config dump | grep SystemdCgroup

# 4. Проверка сетевого плагина (Calico)
kubectl get pods -n calico-system
kubectl logs -n calico-system -l k8s-app=calico-node
```

### Проблема: Dashboard недоступен

```bash
# Проверка сервиса и подов
kubectl get svc -n kubernetes-dashboard
kubectl get pods -n kubernetes-dashboard

# Проверка статуса Kong proxy
kubectl get pods -n kubernetes-dashboard -l app.kubernetes.io/name=kong

# Логи Kong
kubectl logs -n kubernetes-dashboard -l app.kubernetes.io/name=kong
```

### Проблема: Grafana не отображает метрики

```bash
# Проверка Prometheus
kubectl get pods -n monitoring
kubectl get svc -n monitoring

# Проверка ServiceMonitor
kubectl get servicemonitor -n monitoring

# Логи Prometheus
kubectl logs -n monitoring -l app.kubernetes.io/name=prometheus
```

### Проблема: SSH подключение не работает

```bash
# Проверка SSH доступа
ssh -i ~/.ssh/id_rsa ubuntu@<IP> -v

# Проверка authorized_keys на сервере
ssh ubuntu@<IP> "cat ~/.ssh/authorized_keys"

# Добавление ключа заново
ssh-copy-id -i ~/.ssh/id_rsa.pub ubuntu@<IP>
```

### Проблема: Ansible не находит Python

```bash
# На узле проверка наличия Python
ssh ubuntu@<IP> which python3.12

# Установка Python
ssh ubuntu@<IP> "sudo apt update && sudo apt install -y python3.12"

# Обновите inventory с правильным путем
# inventories/hosts.yml:
ansible_python_interpreter: /usr/bin/python3.12
```

---

## Очистка и удаление

### Полная очистка кластера (со всеми данными)

```bash
# На мастере
kubectl drain --ignore-daemonsets --delete-emptydir-data <NODE_NAME>
kubeadm reset --force
sudo systemctl stop kubelet
sudo rm -rf /etc/kubernetes
sudo rm -rf /var/lib/kubelet
sudo rm -rf /var/lib/etcd

# На worker узлах
ssh ubuntu@<NODE_IP>
sudo kubeadm reset --force
sudo systemctl stop kubelet
sudo rm -rf /etc/kubernetes
sudo rm -rf /var/lib/kubelet
```

### Удаление конкретных приложений

```bash
# Удаление Dashboard
helm uninstall kubernetes-dashboard -n kubernetes-dashboard
kubectl delete namespace kubernetes-dashboard

# Удаление Prometheus Stack
helm uninstall prometheus -n monitoring
kubectl delete namespace monitoring

# Удаление Nginx
ssh ubuntu@<MASTER_IP>
sudo systemctl stop nginx
sudo apt remove -y nginx
```

### Переустановка плейбука

Если необходимо переустановить конкретный плейбук:

```bash
# Очистка и переустановка Dashboard
ansible-playbook install-dashboard-monitoring.yml --extra-vars="force_reinstall=true"

# Или вручную
helm uninstall kubernetes-dashboard -n kubernetes-dashboard
ansible-playbook install-dashboard-monitoring.yml
```

---

## Расширение кластера

### Добавление нового worker узла

1. Добавьте узел в `inventories/hosts.yml`:

```yaml
K8S-nodes:
  hosts:
    kubernetes-node-4:
      ansible_host: 192.168.1.104
      ansible_user: ubuntu
```

2. Выполните плейбук для новых узлов:

```bash
ansible-playbook -i inventories/hosts.yml install-node.yml \
  -l kubernetes-node-4
```

3. Проверьте статус:

```bash
kubectl get nodes
```

---

## Переменные окружения и secrets

### Сохраняемые данные

- `secrets/kubeadm-join.yml` - Токен для присоединения узлов (автоматически)
- `~/.kube/config` - Kubeconfig на локальной машине (автоматически)
- `/etc/kubernetes/admin.conf` - Kubeconfig на мастере

### Безопасность

- **Dashboard токен** выводится один раз при развертывании (сохраните!)
- **Grafana пароль**: `prom-operator` (измените после развертывания)
- **SSH ключи**: используйте SSH с аутентификацией по ключам

---

## Поддерживаемые версии

| Компонент | Версия |
|---|---|
| Kubernetes | v1.34 |
| containerd | Latest |
| Calico CNI | v3.27.0 |
| Helm | 3.x |
| Ubuntu | 24.04 LTS |
| Ansible | 2.9+ |

---

## Полезные команды

### Мониторинг кластера

```bash
# Реал-тайм статус узлов
watch kubectl get nodes -o wide

# Использование ресурсов
kubectl top nodes
kubectl top pods -A

# События кластера
kubectl get events -A --sort-by='.lastTimestamp'

# Проверка статуса сервисов
kubectl get svc -A
kubectl get endpoints -A
```

### Управление подами

```bash
# Перезагрузка подов
kubectl rollout restart deployment/<NAME> -n <NAMESPACE>

# Масштабирование
kubectl scale deployment/<NAME> --replicas=3 -n <NAMESPACE>

# Удаление pod (пересоздастся)
kubectl delete pod <POD_NAME> -n <NAMESPACE>
```

### Отладка

```bash
# Логи пода
kubectl logs <POD_NAME> -n <NAMESPACE>
kubectl logs <POD_NAME> -n <NAMESPACE> --previous  # предыдущие логи
kubectl logs <POD_NAME> -n <NAMESPACE> -f  # следить за логами

# Описание ресурса
kubectl describe pod <POD_NAME> -n <NAMESPACE>
kubectl describe node <NODE_NAME>

# Интерактивный shell
kubectl exec -it <POD_NAME> -n <NAMESPACE> -- /bin/bash
```

---

## Лицензия

MIT License

---

## Поддержка и обратная связь

При возникновении проблем:

1. Проверьте логи плейбуков: `ansible-playbook ... -vvv`
2. Проверьте логи системных сервисов: `journalctl -u kubelet`
3. Проверьте логи подов: `kubectl logs -n <NAMESPACE> <POD_NAME>`
4. Убедитесь, что все узлы имеют доступ в интернет
5. Проверьте требования к ресурсам (CPU, RAM, место на диске)

---

## Заметки о безопасности

⚠️ **Эти плейбуки предназначены для тестирования и разработки!**

Для production окружения рекомендуется:

- Использовать TLS сертификаты (вместо self-signed)
- Включить Network Policies для изоляции сетей
- Использовать RBAC для ограничения доступа
- Регулярно обновлять Kubernetes и компоненты
- Настроить логирование и аудит
- Использовать secrets manager (Vault, AWS Secrets Manager и т.д.)
- Резервное копирование etcd

---

**Создано:** Декабрь 2025  
**Последнее обновление:** 29.12.2025