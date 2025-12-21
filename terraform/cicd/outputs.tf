output "registry_id" {
  value       = yandex_container_registry.registry.id
  description = "YCR Registry ID (используйте в GitHub Secrets: REGISTRY_ID)"
}

output "registry_url" {
  value       = "cr.yandex/${yandex_container_registry.registry.id}"
  description = "Полный URL реестра"
}

output "service_account_id" {
  value = yandex_iam_service_account.cicd_sa.id
}

output "sa_access_key" {
  value       = yandex_iam_service_account_static_access_key.cicd_sa_key.access_key
  description = "Access Key ID"
}

output "sa_secret_key" {
  value       = yandex_iam_service_account_static_access_key.cicd_sa_key.secret_key
  description = "Secret Access Key"
  sensitive   = true
}

output "connect_string" {
  value = nonsensitive("ycr ${yandex_container_registry.registry.id} ${yandex_iam_service_account_static_access_key.cicd_sa_key.access_key} ${yandex_iam_service_account_static_access_key.cicd_sa_key.secret_key}")
  description = "Строка подключения для docker login"
  sensitive   = true
}