# Kubernetes Deployment: Dio App

Развертывание приложения dio-app в Kubernetes с использованием Yandex Container Registry и NodePort сервиса.

## Требования

- Kubernetes кластер (Yandex Managed Kubernetes или аналогичный)
- kubectl настроенный для доступа к кластеру
- Secret `ycr-secret` для доступа к Yandex Container Registry
- 2 реплики подов с лимитами CPU 100m и памяти 128Mi

## Файлы манифестов

```
app-deployment.yaml  - Deployment с 2 репликами
app-service.yaml     - NodePort сервис на порту 30080
```

## Развертывание

Примените манифесты в указанном порядке:

```
kubectl apply -f app-deployment.yaml
kubectl apply -f app-service.yaml
```

Проверьте статус:

```
kubectl get deployments dio-app
kubectl get services dio-app-service
kubectl get pods -l app=dio-app
```

## Доступ к приложению

Сервис доступен на всех нодах кластера по адресу `<node-ip>:30080`.

Пример:
```
curl http://<node-ip>:30080
```

## Описание ресурсов

| Ресурс | Тип | Реплики | Порт | Лимиты |
|--------|-----|---------|------|--------|
| dio-app | Deployment | 2 | 80 | CPU: 100m, Mem: 128Mi |
| dio-app-service | NodePort | - | 80→30080 | - |

## Удаление

```
kubectl delete -f app-service.yaml
kubectl delete -f app-deployment.yaml
```

## Замечания

- Образ `cr.yandex/crpom655acgl1rhhnucb/dio-app:latest` тянется из приватного Yandex Container Registry
- NodePort 30080 открывается на всех нодах автоматически через kube-proxy
- Для продакшена рекомендуется LoadBalancer вместо NodePort
