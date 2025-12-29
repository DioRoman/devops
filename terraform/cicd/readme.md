# CI/CD с автоматическим сканированием образов в Yandex Cloud

Terraform-модуль для развертывания Container Registry, Cloud Function и триггера для автоматического сканирования Docker-образов при push. Использует единый сервисный аккаунт для CI/CD (GitHub Actions) и сканирования уязвимостей.

## Предварительные требования

- Установленный Terraform >=1.8 и Yandex CLI (yc).
- Файл `~/.authorized_key.json` с правами на folder_id.
- Архив `function.zip` с `handler.sh` для запуска `yc container image scan --async`.
- Доступ к folder_id `b1g22qi1cc8rq4avqgik` и cloud_id `b1g2uh898q9ekgq43tfq`.

## Развертывание

1. Перейдите в директорию проекта:
   ```
   cd /mnt/c/Users/rlyst/Netology/devops/terraform/cicd
   ```

2. Инициализация и применение:
   ```
   terraform init
   terraform apply --auto-approve
   ```

3. Сохраните outputs в GitHub Secrets:
   - `REGISTRY_ID`: registry_id
   - `REGISTRY_URL`: registry_url  
   - `ACCESS_KEY`: sa_access_key
   - `SECRET_KEY`: sa_secret_key
   - `CONNECT_STRING`: connect_string (для docker login).

Terraform сохраняет состояние в S3-backend (`dio-bucket/terraform-learning/terraform-cicd.tfstate`) с DynamoDB-локами.

## Архитектура

```
GitHub Actions → Push в Registry → Trigger → Cloud Function → yc image scan
```

| Компонент | Описание |
|-----------|----------|
| cicd_sa | Единый SA: pusher, scanner, puller, viewer, functionInvoker  |
| my-registry | Реестр с лейблами env=dev, app=nginx-app |
| scan-on-push | Bash-функция (128MB, 60s timeout) из function.zip |
| trigger-for-reg | Триггер на create_image_tag (batch=1, cutoff=10s) |

## Использование в GitHub Actions

```yaml
- name: Login to Yandex Container Registry
  run: echo "${{ secrets.CONNECT_STRING }}" | docker login --username yc-user --password-stdin ${{ secrets.REGISTRY_URL }}

- name: Push image
  run: |
    docker tag nginx:latest ${{ secrets.REGISTRY_URL }}/nginx:latest
    docker push ${{ secrets.REGISTRY_URL }}/nginx:latest
```

Триггер автоматически запустит сканирование.

## Проверка результатов

- Логи функции: `yc serverless function logs scan-on-push`
- Результаты сканирования: `yc container image list-scan-results --registry-id $REGISTRY_ID`
- Статус образов: Консоль → Container Registry → Репозитории.

## Очистка

```
terraform destroy --auto-approve
```

## Возможные улучшения

- Добавить фильтры триггера по image_name/tag.
- Разделить SA на CI/CD и scanner.
- GitHub Actions workflow для полного CI/CD пайплайна.

Проект основан на официальных примерах Yandex Cloud.