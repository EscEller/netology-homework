data "yandex_compute_image" "ubuntu_2204_lts" {
  family = "ubuntu-2404-lts"
}

resource "yandex_compute_instance" "bastion" {
  name        = "bastion" # Имя ВМ в облачной консоли
  hostname    = "bastion" # формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-a" # зона ВМ должна совпадать с зоной subnet!!!
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      name = "hdd-bastion"
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  # scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.LAN.id, yandex_vpc_security_group.bastion.id]
  }
}

resource "yandex_compute_instance" "zabbix" {

  name        = "zabbix" # Имя ВМ в облачной консоли
  hostname    = "zabbix" # формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-a"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      name = "hdd-zabbix"
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  # scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.public.id]
  }
}

resource "yandex_compute_instance" "kibana" {

  name        = "kibana" # Имя ВМ в облачной консоли
  hostname    = "kibana" # формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-a"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      name = "hdd-kibana"
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  # scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.public.id]
  }
}

resource "yandex_compute_instance" "elastic" {

  name        = "elastic" # Имя ВМ в облачной консоли
  hostname    = "elastic" # формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-a"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      name = "hdd-elastic"
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  # scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-internal.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.LAN.id, yandex_vpc_security_group.web.id]
  }
}

resource "yandex_compute_instance" "web-vm1" {

  name        = "web-vm1" # Имя ВМ в облачной консоли
  hostname    = "web-vm1" # формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-a" # зона ВМ должна совпадать с зоной subnet!!!
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      name = "hdd-web-vm1"
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  # scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-web-vm1.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.LAN.id, yandex_vpc_security_group.web.id]
  }
}

resource "yandex_compute_instance" "web-vm2" {

  name        = "web-vm2" # Имя ВМ в облачной консоли
  hostname    = "web-vm2" # формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-b" # зона ВМ должна совпадать с зоной subnet!!!
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      name = "hdd-web-vm2"
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  # scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-web-vm2.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.LAN.id, yandex_vpc_security_group.web.id]
  }
}

resource "yandex_alb_load_balancer" "alb" {
  name = "alb"
  
  network_id = yandex_vpc_network.network-neto.id


  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-web-vm1.id
    }
    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.subnet-web-vm2.id
    }
  }
  
    listener {
    name = "http-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.alb_router.id
        allow_http10   = true
      }
    }
  }
}

resource "yandex_alb_target_group" "alb-group" {
  name = "alb-group"

  target {
    subnet_id = yandex_vpc_subnet.subnet-web-vm1.id
    ip_address = yandex_compute_instance.web-vm1.network_interface.0.ip_address
  }
  target {
    subnet_id = yandex_vpc_subnet.subnet-web-vm2.id
    ip_address = yandex_compute_instance.web-vm2.network_interface.0.ip_address
  }
}

resource "yandex_alb_backend_group" "alb-backend" {
  name = "alb-backend"

  http_backend {
    name                   = "alb-http-backend"
    weight                 = 1
    port                   = 80
    target_group_ids       = [yandex_alb_target_group.alb-group.id]
    load_balancing_config {
      panic_threshold = 90
    }  
    
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      http_healthcheck {
        path              = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "alb_router" {
  name        = "alb-router"
}

resource "yandex_alb_virtual_host" "web_host" {
  name           = "web-virtual-host"
  http_router_id = yandex_alb_http_router.alb_router.id
  route {
    name = "default-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.alb-backend.id
        timeout          = "60s"
        idle_timeout     = "60s"
      }
    }
  }
  authority = ["*"]
}

resource "null_resource" "write_kibana_host" {
  depends_on = [
    yandex_compute_instance.kibana,
    yandex_compute_instance.bastion
  ]

  provisioner "remote-exec" {
    connection {
      host        = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
      user        = "o.kuzubov"
      private_key = file("~/.ssh/id_rsa") 
    }

    inline = [
      "echo '${yandex_compute_instance.kibana.network_interface[0].nat_ip_address} kibana.ru-central1.internal' | sudo tee -a /etc/hosts > /dev/null",
      "echo '${yandex_compute_instance.zabbix.network_interface[0].nat_ip_address} zabbix.ru-central1.internal' | sudo tee -a /etc/hosts > /dev/null"
    ]
  }
}

resource "local_file" "inventory" {
  content  = <<-XYZ
  [all:vars]
  ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q o.kuzubov@${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}"'

  [utility-servers]
  bastion ansible_host=${yandex_compute_instance.bastion.fqdn}
  zabbix ansible_host=${yandex_compute_instance.zabbix.fqdn}
  kibana ansible_host=${yandex_compute_instance.kibana.fqdn} 
  elastic ansible_host=${yandex_compute_instance.elastic.fqdn}
  
  [webservers]
  web-vm1 ansible_host=${yandex_compute_instance.web-vm1.fqdn}
  web-vm2 ansible_host=${yandex_compute_instance.web-vm2.fqdn}
  XYZ
  filename = "./hosts.ini"
}
