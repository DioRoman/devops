### Terraform

- Перейти в каталог с конфигурацией:
  - `cd /mnt/c/Users/rlyst/Netology/devops/terraform/infrastructure`
- Инициализировать Terraform:
  - `terraform init`
- Применить инфраструктуру (создать кластер):
  - `terraform apply -auto-approve`
- Удалить инфраструктуру:
  - `terraform destroy -auto-approve`

***

### Ansible

- Перейти в каталог с плейбуками:
  - `cd /mnt/c/Users/rlyst/Netology/devops/ansible`
- Установить master-узел:
  - `ansible-playbook -i inventories/hosts.yml install-master.yml`
- Установить worker-узлы:
  - `ansible-playbook -i inventories/hosts.yml install-node.yml --extra-vars "kube_join_command='kubeadm join k8s-master:6443 --token t2i8c1.enedg87zcpa2cpjc --discovery-token-ca-cert-hash sha256:7952fdb832b4a337a9f755956790005657c5d20b00d9e11e0fb6b78f4cfd6b58'"`
- Установить dashboard:
  - `ansible-playbook -i inventories/hosts.yml dashboard.yml`
- Подключиться к кластеру локально:
  - `ansible-playbook -i inventories/hosts.yml localhost-connect-k8s-cluster.yml --ask-become-pass`
  

***

### Тестирование и отладка

- Создать тестовый Pod:
  - `kubectl run test-pod --image=wbitt/network-multitool --rm -it -- sh`
- Тестировать доступность сервисов (из Pod или локально):
  - `curl <service-name>:<порт>`
  - `curl http://localhost:8080`
  - `curl http://62.84.116.85/` и `curl http://62.84.116.85/api`

***

### Кластер Kubernetes (master/worker) через kubeadm

- Сгенерировать config для containerd:
  - `sudo containerd config default > /etc/containerd/config.toml`
- Удалить старый сокет containerd:
  - `sudo rm -rf /var/run/containerd/containerd.sock`
- Сбросить состояние кластера:
  - `sudo kubeadm reset`
- Инициализировать master-узел:
  - `sudo kubeadm init --apiserver-advertise-address=10.0.2.18 --pod-network-cidr=10.244.0.0/16 --apiserver-cert-extra-sans=51.250.92.109,178.154.234.213 --control-plane-endpoint=10.0.2.18`
- Экспортировать конфиг для kubectl:
  - `export KUBECONFIG=/etc/kubernetes/admin.conf`
- Включить IP forwarding:
  - `echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf`
  - `sysctl -p`
- Проверить статус кластера:
  - `kubectl get nodes`
  - `kubectl get pods -A`
- Применить Flannel:
  - `kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml`
- Присоединить worker (через Ansible):
  - `ansible-playbook -i inventories/hosts.yml install-node.yml --extra-vars "kube_join_command='kubeadm join k8s-master:6443 --token dpencc.djfyv2om1tljpdps --discovery-token-ca-cert-hash sha256:d75b3e798e04826d3c4528883ce03ffe9c0592acca248c959f71120463ea3fd8'"`

### Добавление кластера
mkdir /home/dio/.kube/
scp ubuntu@158.160.104.6:/home/ubuntu/.kube/config ~/.kube/config
chmod 600 ~/.kube/config
sudo mcedit /etc/hosts
158.160.104.6 k8s-master
kubectl get nodes

# Установите kube-prometheus-stack в namespace monitoring
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
  --set prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues=false

### Основные команды для работы

- **Проверка статуса подов:**
  ```bash
  kubectl --namespace monitoring get pods -l "release=prometheus"
  ```

- **Получение пароля администратора Grafana:**
  ```bash
  kubectl --namespace monitoring get secrets prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo
  ```

- **Доступ к Grafana через port-forward:**
  ```bash
  export POD_NAME=$(kubectl --namespace monitoring get pod -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=prometheus" -o name)
  kubectl --namespace monitoring port-forward $POD_NAME 3000
  ```
  После выполнения откройте в браузере `http://localhost:3000` и используйте полученный пароль.

- **Получение пароля администратора (альтернативный способ):**
  ```bash
  kubectl get secret --namespace monitoring -l app.kubernetes.io/component=admin-secret -o jsonpath="{.items[0].data.admin-password}" | base64 --decode ; echo
  ```

docker build -t my-horoscope-app .
docker run -p 8080:80 my-horoscope-app