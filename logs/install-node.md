
dio@ROMANPC:/mnt/c/Users/rlyst/Netology/devops/ansible$ ansible-playbook -i inventories/hosts.yml install-node.yml --ask-vault-pass
[WARNING]: Ansible is being run in a world writable directory (/mnt/c/Users/rlyst/Netology/devops/ansible), ignoring it as an ansible.cfg source. For more information see https://docs.ansible.com/ansible/devel/reference_app
endices/config.html#cfg-in-world-writable-dir
Vault password:
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details

PLAY [Установка и настройка Kubernetes worker-node] ***************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************************
ok: [kubernetes-node-3]
ok: [kubernetes-node-2]
ok: [kubernetes-node-1]

TASK [Загрузить зашифрованную команду join] ***********************************************************************************************************************************************************************************
ok: [kubernetes-node-1]

TASK [Установка базовых зависимостей] *****************************************************************************************************************************************************************************************
ok: [kubernetes-node-1]
ok: [kubernetes-node-3]
ok: [kubernetes-node-2]

TASK [Создать каталог для APT keyrings] ***************************************************************************************************************************************************************************************
ok: [kubernetes-node-1]
ok: [kubernetes-node-3]
ok: [kubernetes-node-2]

TASK [Добавление GPG ключа Docker] ********************************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-3]
changed: [kubernetes-node-2]

TASK [Добавление Docker репозитория] ******************************************************************************************************************************************************************************************
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]
changed: [kubernetes-node-1]

TASK [Установка containerd] ***************************************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Удалить старый config.toml containerd если есть] ************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-3]
changed: [kubernetes-node-2]

TASK [Сгенерировать правильный config.toml для containerd через tee] **********************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Включить SystemdCgroup в containerd (toml)] *****************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-3]
changed: [kubernetes-node-2]

TASK [Перезапустить containerd для пересчитывания конфига] ********************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Загрузка GPG ключа Kubernetes (pkgs.k8s.io)] ****************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Добавление репозитория Kubernetes] **************************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Обновить индекс пакетов (Kubernetes repo)] ******************************************************************************************************************************************************************************
changed: [kubernetes-node-2]
changed: [kubernetes-node-1]
changed: [kubernetes-node-3]

TASK [Установить kubelet, kubeadm, kubectl] ***********************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Фиксация версий Kubernetes компонентов (apt-mark hold)] *****************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Включить и запустить kubelet] *******************************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-3]
changed: [kubernetes-node-2]

TASK [Отключить swap] *********************************************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-3]
changed: [kubernetes-node-2]

TASK [Закомментировать swap в fstab] ******************************************************************************************************************************************************************************************
ok: [kubernetes-node-1]
ok: [kubernetes-node-2]
ok: [kubernetes-node-3]

TASK [Загрузить модули ядра] **************************************************************************************************************************************************************************************************
changed: [kubernetes-node-1] => (item=overlay)
changed: [kubernetes-node-2] => (item=overlay)
changed: [kubernetes-node-3] => (item=overlay)
changed: [kubernetes-node-1] => (item=br_netfilter)
changed: [kubernetes-node-2] => (item=br_netfilter)
changed: [kubernetes-node-3] => (item=br_netfilter)

TASK [Настроить sysctl параметры] *********************************************************************************************************************************************************************************************
changed: [kubernetes-node-1] => (item={'name': 'net.bridge.bridge-nf-call-iptables', 'value': '1'})
changed: [kubernetes-node-2] => (item={'name': 'net.bridge.bridge-nf-call-iptables', 'value': '1'})
changed: [kubernetes-node-1] => (item={'name': 'net.ipv4.ip_forward', 'value': '1'})
changed: [kubernetes-node-2] => (item={'name': 'net.ipv4.ip_forward', 'value': '1'})
changed: [kubernetes-node-3] => (item={'name': 'net.bridge.bridge-nf-call-iptables', 'value': '1'})
changed: [kubernetes-node-1] => (item={'name': 'net.bridge.bridge-nf-call-ip6tables', 'value': '1'})
changed: [kubernetes-node-2] => (item={'name': 'net.bridge.bridge-nf-call-ip6tables', 'value': '1'})
changed: [kubernetes-node-3] => (item={'name': 'net.ipv4.ip_forward', 'value': '1'})
changed: [kubernetes-node-3] => (item={'name': 'net.bridge.bridge-nf-call-ip6tables', 'value': '1'})

TASK [Добавить master в /etc/hosts] *******************************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Остановить kubelet] *****************************************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Удалить старые kubernetes конфиги (если есть)] **************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Демонтировать все kube-api-access директории] ***************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Удалить /var/lib/kubelet] ***********************************************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Демонтировать принудительно все /var/lib/kubelet submounts] *************************************************************************************************************************************************************
changed: [kubernetes-node-1]
changed: [kubernetes-node-2]
changed: [kubernetes-node-3]

TASK [Получить список узлов кластера] *****************************************************************************************************************************************************************************************
ok: [kubernetes-node-1]
ok: [kubernetes-node-2]
ok: [kubernetes-node-3]

TASK [Присоединить узел к кластеру (kubeadm join), если узел отсутствует в кластере] ******************************************************************************************************************************************
changed: [kubernetes-node-2]
changed: [kubernetes-node-1]
changed: [kubernetes-node-3]

TASK [Проверка присоединения узла (kubectl get nodes)] ************************************************************************************************************************************************************************
ok: [kubernetes-node-1]
ok: [kubernetes-node-2]
ok: [kubernetes-node-3]

TASK [Отладка вывода проверки] ************************************************************************************************************************************************************************************************
ok: [kubernetes-node-1] => {
    "nodes_check.stdout": ""
}
ok: [kubernetes-node-2] => {
    "nodes_check.stdout": ""
}
ok: [kubernetes-node-3] => {
    "nodes_check.stdout": ""
}

PLAY RECAP ********************************************************************************************************************************************************************************************************************
kubernetes-node-1          : ok=31   changed=23   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
kubernetes-node-2          : ok=30   changed=23   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
kubernetes-node-3          : ok=30   changed=23   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
