# Домашнее задание к занятию «Отказоустойчивость в облаке»


## Задание 1

Возьмите за основу [решение к заданию 1 из занятия «Подъём инфраструктуры в Яндекс Облаке»](https://github.com/netology-code/sdvps-homeworks/blob/main/7-03.md#задание-1).

1. Теперь вместо одной виртуальной машины сделайте terraform playbook, который:

- создаст 2 идентичные виртуальные машины. Используйте аргумент [count](https://www.terraform.io/docs/language/meta-arguments/count.html) для создания таких ресурсов;
- создаст [таргет-группу](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_target_group). Поместите в неё созданные на шаге 1 виртуальные машины;
- создаст [сетевой балансировщик нагрузки](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer), который слушает на порту 80, отправляет трафик на порт 80 виртуальных машин и http healthcheck на порт 80 виртуальных машин.

Рекомендуем изучить [документацию сетевого балансировщика нагрузки](https://cloud.yandex.ru/docs/network-load-balancer/quickstart) для того, чтобы было понятно, что вы сделали.

2. Установите на созданные виртуальные машины пакет Nginx любым удобным способом и запустите Nginx веб-сервер на порту 80.

3. Перейдите в веб-консоль Yandex Cloud и убедитесь, что:

- созданный балансировщик находится в статусе Active,
- обе виртуальные машины в целевой группе находятся в состоянии healthy.

4. Сделайте запрос на 80 порт на внешний IP-адрес балансировщика и убедитесь, что вы получаете ответ в виде дефолтной страницы Nginx.

*В качестве результата пришлите:*

*1. Terraform Playbook.*

*2. Скриншот статуса балансировщика и целевой группы.*

*3. Скриншот страницы, которая открылась при запросе IP-адреса балансировщика.*


### Ответ 1

[provider.tf](https://github.com/EscEller/netology-homework/blob/main/sflt-04/content/provider.tf)

```
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
```

[output.tf](https://github.com/EscEller/netology-homework/blob/main/sflt-04/content/provider.tf)

```
output "vms" {
  value = {
    for name, vm in yandex_compute_instance.vm : vm.name => vm.network_interface.0.nat_ip_address
  }
}

output "lbs" {
  value = {
    for listener in yandex_lb_network_load_balancer.balancer-neto.listener : listener.name => [
      for spec in listener.external_address_spec : spec.address
    ]
  }
}
```

[ansible_inventory.tf](https://github.com/EscEller/netology-homework/blob/main/sflt-04/content/ansible_inventory.tf)

```
resource "local_file" "ansible_inventory" {
  file_permission = "0644"
  filename = "${path.module}/../ansible/inventory.ini"
  content = <<EOT
[all]
%{for host in yandex_compute_instance.vm~}
${trimspace("${host.name} ansible_host=${host.network_interface.0.nat_ip_address}")}
%{endfor~}
EOT
}
```

[vms.tf](https://github.com/EscEller/netology-homework/blob/main/sflt-04/content/vms.tf)

```
data "yandex_compute_image" "ubuntu_2204_lts" {
  family = "ubuntu-2204-lts"
}


resource "yandex_lb_target_group" "group-neto" {
  name = "group1"

  dynamic "target" {
    for_each = yandex_compute_instance.vm
    content {
      subnet_id = yandex_vpc_subnet.subnet-neto.id
      address = target.value.network_interface.0.ip_address
    }
  }
}


resource "yandex_compute_instance" "vm" {

  count = 2

  name        = "web-vm-${count.index}" #Имя ВМ в облачной консоли
  hostname    = "web-vm-${count.index}" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-a" #зона ВМ должна совпадать с зоной subnet!!!


  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-neto.id
    nat                = true
  }
}


resource "yandex_lb_network_load_balancer" "balancer-neto" {
  name = "balancer1"
  deletion_protection = "false"
  listener {
    name = "my-lb1"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.group-neto.id
    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}



resource "yandex_vpc_network" "network-neto" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-neto" {
  name = "subnet1"
  v4_cidr_blocks = ["172.24.8.0/24"]
  network_id = yandex_vpc_network.network-neto.id
}

```

![Скриншот-1](https://github.com/EscEller/netology-homework/blob/main/sflt-04/content/1.png)

![Скриншот-2](https://github.com/EscEller/netology-homework/blob/main/sflt-04/content/2.png)

![Скриншот-3](https://github.com/EscEller/netology-homework/blob/main/sflt-04/content/3.png)
