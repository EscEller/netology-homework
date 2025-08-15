terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  #token = var.oauth_token
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  service_account_key_file = file("~/terraform/authorized_key.json")
  zone = "ru-central1-a"
}
