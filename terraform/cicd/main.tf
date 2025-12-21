# Единый SA для CI/CD и Function
resource "yandex_iam_service_account" "cicd_sa" {
  folder_id = var.folder_id
  name      = "dio-cicd"
  description = "SA для CI/CD push и автоматического сканирования образов"
}

# Статический ключ для GitHub Actions
resource "yandex_iam_service_account_static_access_key" "cicd_sa_key" {
  service_account_id = yandex_iam_service_account.cicd_sa.id
  description        = "Static key for GitHub Actions"
}

# Роли для единого SA через for_each
resource "yandex_resourcemanager_folder_iam_member" "cicd_roles" {
  for_each = toset([
    "container-registry.images.pusher",
    "container-registry.images.scanner",
    "functions.functionInvoker"
  ])
  folder_id = var.folder_id
  role      = each.value
  member    = "serviceAccount:${yandex_iam_service_account.cicd_sa.id}"
}

# Container Registry
resource "yandex_container_registry" "registry" {
  folder_id = var.folder_id
  name      = local.registry_name
  labels = {
    env  = "dev"
    app  = "nginx-app"
  }
}

# Cloud Function для сканирования
resource "yandex_function" "scanner" {
  name               = local.function_name
  user_hash          = filesha256("function.zip")
  runtime            = "bash"
  entrypoint         = "handler.sh"
  memory             = 128
  execution_timeout  = 60
  service_account_id = yandex_iam_service_account.cicd_sa.id

  content {
    zip_filename = "function.zip"
  }
}

# Триггер на события реестра
resource "yandex_function_trigger" "trigger" {
  name = local.trigger_name

  function {
    id                 = yandex_function.scanner.id
    service_account_id = yandex_iam_service_account.cicd_sa.id
  }

  container_registry {
    registry_id      = yandex_container_registry.registry.id
    create_image_tag = true
    batch_size       = 1
    batch_cutoff     = 10
  }
}