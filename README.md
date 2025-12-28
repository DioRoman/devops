Старт проекта

Маленький кластер K8S для небольшого приложения 4 ноды (1 мастер)

1. Переходим в каталог с Terraform
`cd /mnt/c/Users/rlyst/Netology/devops/terraform/infrastructure`

2. Применяем
`terraform apply -auto-approve`

1. Переходим в каталог с Terraform
`cd /mnt/c/Users/rlyst/Netology/devops/terraform/cicd`

2. Применяем
`terraform apply -auto-approve`

3. Переходим в каталог с Ansible

`cd /mnt/c/Users/rlyst/Netology/devops/ansible`

4. Запускаем установку Master-ноды

`ansible-playbook -i inventories/hosts.yml install-master.yml`

5. Шифруем команду join

`ansible-vault encrypt secrets/kubeadm-join.yml`

5. Запускаем установку и join 3 нод.

`ansible-playbook -i inventories/hosts.yml install-node.yml --ask-vault-pass`
 
6. Устанавливаем Dashboard и мониторинг

`ansible-playbook -i inventories/hosts.yml install-dashboard-monitoring.yml`

https://master-ip:30443 - dashboard k8s

http://master-ip:30001 - grafana (после входа меняем пароль)

7. Подлючаемся к кластеру локально

`ansible-playbook -i inventories/hosts.yml localhost-connect-k8s-cluster.yml --ask-become-pass`

8. Запускаем nginx прокси

`ansible-playbook -i inventories/hosts.yml install-nginx-proxy.yml`

8. Предварительно создаем secret для доступа к Yandex Cloud Conteriner Registry под сервисным аккаунтом dio-cicd. Команда создает Service Account Key для Yandex Cloud IAM в формате JSON.

`yc iam key create --service-account-name dio-cicd --output key.json`

Повторно генерить необязательно

9. Создаем Kubernetes Secret для авторизации подов в Yandex Container Registry.

kubectl create secret docker-registry ycr-secret \
  --docker-server=cr.yandex \
  --docker-username=json_key \
  --docker-password="$(cat key.json)" \
  --docker-email=my-sa-for-k8s@example.com

8. Deploy приложения в кластер

`kubectl apply -f /mnt/c/Users/rlyst/Netology/devops/kubernetes/app-deployment.yaml`

`kubectl apply -f /mnt/c/Users/rlyst/Netology/devops/kubernetes/app-service.yaml`

`kubectl apply -f /mnt/c/Users/rlyst/Netology/devops/kubernetes/` - сразу оба

9. Настраиваем CICD

Для работы Workflow GitHub Actions необходимо получить следующие токеты (секреты)

YC_CLOUD_ID - один раз, получить просто.
YC_FOLDER_ID - один раз, получить просто.
YC_REGISTRY_ID - один раз, получить просто.

YC_SA_KEY  - один раз, получаем набором команд:

  Создайте ключ

  `yc iam key create --service-account-id ajetshm48atdt72ukdlb --output sa-key.json`

  Одна строка JSON (для GitHub Secret)

  `cat sa-key.json | jq -c . | tr -d '\n\r'`

KUBE_CONFIG_DATA - один раз, получаем набором команд:

  `kubectl config view --raw > kubeconfig-full.yaml`

  `sed -i 's/k8s-master/89.169.128.245/g' kubeconfig-full.yaml`

  Base64 для GitHub Secret

  `base64 -w 0 kubeconfig-full.yaml | xclip -sel clip`
