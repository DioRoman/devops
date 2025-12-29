# Развертывание K8s кластера и приложения

## Список всех readme.md

Terraform infrastructure https://github.com/DioRoman/devops/blob/main/terraform/infrastructure/readme.md

Terraform cicd           https://github.com/DioRoman/devops/blob/main/terraform/cicd/readme.md

Ansible                  https://github.com/DioRoman/devops/blob/main/ansible/readme.md

Kubernetes               https://github.com/DioRoman/devops/blob/main/kubernetes/readme.md

dio-app                  https://github.com/DioRoman/dio-app/blob/main/README.md

## Инструкция по пошаговому развертыванию небольшого Kubernetes кластера (1 мастер + 3 воркера) в Yandex Cloud с CICD через GitHub Actions.

## Предварительная подготовка

Перейдите в каталог с Terraform инфраструктурой и примените конфигурацию:
```
cd /mnt/c/Users/rlyst/Netology/devops/terraform/infrastructure
terraform apply -auto-approve
```
Время выполнения: 1 минута.

VM

<img width="2467" height="451" alt="Снимок экрана 2025-12-30 005457" src="https://github.com/user-attachments/assets/abfb6a54-2cb3-4a28-87af-9c0534986e46" />

VPC

<img width="1783" height="415" alt="Снимок экрана 2025-12-30 005632" src="https://github.com/user-attachments/assets/5cc23502-db09-4c44-8e19-2a8a2990d238" />

S3 Bucket

<img width="1182" height="360" alt="Снимок экрана 2025-12-30 005621" src="https://github.com/user-attachments/assets/16430999-4f0d-4f7c-afa4-f31d8cf8bd07" />

Затем настройте CICD:
```
cd /mnt/c/Users/rlyst/Netology/devops/terraform/cicd
terraform apply -auto-approve
```
Время выполнения: 1 минута.

Сервисный аккаунт

<img width="1259" height="120" alt="Снимок экрана 2025-12-30 005845" src="https://github.com/user-attachments/assets/6ff268e2-9c9e-4e6b-a876-70557fba8bb1" />

Контейнер регистри

<img width="1387" height="252" alt="Снимок экрана 2025-12-30 005855" src="https://github.com/user-attachments/assets/6b2bdde6-bb0e-4ab3-96dd-2ad77465ae73" />

Скан задача

<img width="1438" height="312" alt="Снимок экрана 2025-12-30 005906" src="https://github.com/user-attachments/assets/61d0d5ea-e80b-44f7-b665-dd8737f3f026" />

## Установка Kubernetes

Перейдите в каталог Ansible и установите мастер-ноду:
```
cd /mnt/c/Users/rlyst/Netology/devops/ansible
ansible-playbook -i inventories/hosts.yml install-master.yml
```
Время выполнения: 3 минуты.

Зашифруйте команду join:
```
ansible-vault encrypt secrets/kubeadm-join.yml
```

Установите воркеры:
```
ansible-playbook -i inventories/hosts.yml install-node.yml --ask-vault-pass
```

Время выполнения: 3 минуты.

Установите Dashboard и мониторинг:
```
ansible-playbook -i inventories/hosts.yml install-dashboard-monitoring.yml
```

**Доступ:**

- Dashboard: `https://master-ip:30443`

<img width="2220" height="1014" alt="Снимок экрана 2025-12-30 011945" src="https://github.com/user-attachments/assets/3226614f-9fb2-491f-9594-6da40e9d9c97" />

- Grafana: `http://master-ip:30001` (смените пароль после входа)

<img width="2210" height="1273" alt="Снимок экрана 2025-12-30 011809" src="https://github.com/user-attachments/assets/c11b946b-f86b-4451-b0f3-a65fdc9c0499" />

Время выполнения: 5 минут.

## Локальное подключение

Подключитесь к кластеру локально:
```
ansible-playbook -i inventories/hosts.yml localhost-connect-k8s-cluster.yml --ask-become-pass
```

Время выполнения: 1 минута.

Установите NGINX прокси, чтобы увидеть наше приложение на 80 порту:
```
ansible-playbook -i inventories/hosts.yml install-nginx-proxy.yml
```

Время выполнения: 1 минута.

## Настройка Container Registry

Создайте секрет для Yandex Container Registry (ycr-secret) и настройте secret для кластера, после чего появится возможность скачивать контейнеры из приватного хранилища yandex cloud registry под сервисным аккаунтом:
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

Переходим http://master-ip/ и видим наше работающее приложение!

<img width="608" height="626" alt="Снимок экрана 2025-12-30 015041" src="https://github.com/user-attachments/assets/d9ed7c83-875e-4d19-b0f3-271252de5069" />

<img width="848" height="580" alt="Снимок экрана 2025-12-30 012824" src="https://github.com/user-attachments/assets/4050f474-943c-470d-8dd3-913d989ae611" />

## Общее время разворачивания кластера и приложения в нём: 15 минут!

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
sed -i 's/k8s-master/<master-ip>/g' kubeconfig-full.yaml
base64 -w 0 kubeconfig-full.yaml | xclip -sel clip
```

## Проверка кластера

```
kubectl get nodes
kubectl get pods -A
```

**Полезные команды для отладки:**
- Под: `kubectl run test-pod --image wbitt/network-multitool --rm -it -- sh`
- Тест сервиса: `curl http://service-name` или `curl http://62.84.116.85`

Если внести в Github Actions secrets and variables правильные данные секретор, то деплой происходит успешно.

<img width="1003" height="442" alt="Снимок экрана 2025-12-30 014738" src="https://github.com/user-attachments/assets/194735d7-475c-4ed2-8933-a39988c1fb7d" />

<img width="2199" height="1064" alt="Снимок экрана 2025-12-30 014633" src="https://github.com/user-attachments/assets/3379a51e-43b5-4293-aaa2-df57321fc29b" />

## Время выполнения деплоя после изменения: 5 минут.
