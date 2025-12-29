# Развертывание K8s кластера и приложения

## Список всех readme.md









## Инструкция по пошаговому развертыванию небольшого Kubernetes кластера (1 мастер + 3 воркера) в Yandex Cloud с CICD через GitHub Actions.

## Предварительная подготовка

Перейдите в каталог с Terraform инфраструктурой и примените конфигурацию:
```
cd /mnt/c/Users/rlyst/Netology/devops/terraform/infrastructure
terraform apply -auto-approve
```

Затем настройте CICD:
```
cd /mnt/c/Users/rlyst/Netology/devops/terraform/cicd
terraform apply -auto-approve
```

## Установка Kubernetes

Перейдите в каталог Ansible и установите мастер-ноду:
```
cd /mnt/c/Users/rlyst/Netology/devops/ansible
ansible-playbook -i inventories/hosts.yml install-master.yml
```

Зашифруйте команду join:
```
ansible-vault encrypt secrets/kubeadm-join.yml
```

Установите воркеры:
```
ansible-playbook -i inventories/hosts.yml install-node.yml --ask-vault-pass
```

Установите Dashboard и мониторинг:
```
ansible-playbook -i inventories/hosts.yml install-dashboard-monitoring.yml
```

**Доступ:**
- Dashboard: `https://master-ip:30443`
- Grafana: `http://master-ip:30001` (смените пароль после входа)[1]

## Локальное подключение

Подключитесь к кластеру локально:
```
ansible-playbook -i inventories/hosts.yml localhost-connect-k8s-cluster.yml --ask-become-pass
```

Установите NGINX прокси:
```
ansible-playbook -i inventories/hosts.yml install-nginx-proxy.yml
```

## Настройка Container Registry

Создайте секрет для Yandex Container Registry (ycr-secret):
```
yc iam key create --service-account-name dio-cicd --output key.json

kubectl create secret docker-registry ycr-secret \
  --docker-server=cr.yandex \
  --docker-username=json_key \
  --docker-password="$(cat key.json)" \
  --docker-email=my-sa-for-k8s@example.com
```

## Деплой приложения

Разверните приложение:
```
kubectl apply -f /mnt/c/Users/rlyst/Netology/devops/kubernetes/app-deployment.yaml
kubectl apply -f /mnt/c/Users/rlyst/Netology/devops/kubernetes/app-service.yaml
```

Или сразу оба:
```
kubectl apply -f /mnt/c/Users/rlyst/Netology/devops/kubernetes/
```

## Настройка GitHub Actions CICD

Получите необходимые секреты для GitHub Workflow:

**Статичные секреты (один раз):**
- `YC_CLOUD_ID`
- `YC_FOLDER_ID` 
- `YC_REGISTRY_ID`

**YC_SA_KEY:**
```
yc iam key create --service-account-id ajetshm48atdt72ukdlb --output sa-key.json
cat sa-key.json | jq -c . | tr -d '\n\r'
```

**KUBE_CONFIG_DATA:**
```
kubectl config view --raw > kubeconfig-full.yaml
sed -i 's/k8s-master/89.169.128.245/g' kubeconfig-full.yaml
base64 -w 0 kubeconfig-full.yaml | xclip -sel clip
```

## Проверка кластера

```
kubectl get nodes
kubectl get pods -A
```

**Полезные команды для отладки:**[1]
- Под: `kubectl run test-pod --image wbitt/network-multitool --rm -it -- sh`
- Тест сервиса: `curl http://service-name` или `curl http://62.84.116.85`

## Общее время запуска приложения

