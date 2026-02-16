resource "yandex_vpc_network" "network-neto" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-web-vm1" {
  name = "subnet-web-vm1"
  v4_cidr_blocks = ["10.0.1.0/24"]
  network_id = yandex_vpc_network.network-neto.id
  zone        = "ru-central1-a"
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_subnet" "subnet-web-vm2" {
  name = "subnet-web-vm2"
  v4_cidr_blocks = ["10.0.2.0/24"]
  network_id = yandex_vpc_network.network-neto.id
  zone        = "ru-central1-b"
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_subnet" "subnet-internal" {
  name = "subnet-internal"
  v4_cidr_blocks = ["10.0.3.0/24"]
  network_id = yandex_vpc_network.network-neto.id
  zone        = "ru-central1-a"
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_subnet" "subnet-public" {
  name = "subnet-public"
  v4_cidr_blocks = ["10.0.4.0/24"]
  network_id = yandex_vpc_network.network-neto.id
  zone        = "ru-central1-a"
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "nat-gateway"
  shared_egress_gateway {}
}

#создаем сетевой маршрут для выхода в интернет через NAT
resource "yandex_vpc_route_table" "route-table" {
  name       = "route-table"
  network_id = yandex_vpc_network.network-neto.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

resource "yandex_vpc_security_group" "bastion" {
  name       = "bastion-sg"
  network_id = yandex_vpc_network.network-neto.id
  
  ingress {
    description    = "Allow 0.0.0.0/0"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    port           = 10051
    v4_cidr_blocks = ["10.0.0.0/8"] 
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

}

resource "yandex_vpc_security_group" "public" {
  name       = "public-sg"
  network_id = yandex_vpc_network.network-neto.id

  ingress {
    description    = "SSH"
    protocol       = "TCP"
    v4_cidr_blocks = ["${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}/32"]
    port           = 22
  }

  ingress {
    description    = "HTTP"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "Kibana"
    protocol       = "TCP"
    port           = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "Proxy"
    protocol       = "TCP"
    v4_cidr_blocks = ["${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}/32"]
    port      = 10051
  }

  egress {
    description    = "All"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "LAN" {
  name       = "LAN-sg"
  network_id = yandex_vpc_network.network-neto.id
  ingress {
    description    = "Allow 10.0.0.0/8"
    protocol       = "ANY"
    v4_cidr_blocks = ["10.0.0.0/8"]
    from_port      = 0
    to_port        = 65535
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

}

resource "yandex_vpc_security_group" "web" {
  name       = "web-sg"
  network_id = yandex_vpc_network.network-neto.id

  ingress {
    description    = "HTTP YC-Healthcheck "
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = [
      "198.18.235.0/24",
      "198.18.236.0/24"
    ]
  }

    egress {
    description    = "HTTP YC-Healthcheck "
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = [
      "198.18.235.0/24",
      "198.18.236.0/24"
    ]
  }

  ingress {
    description    = "HTTP nginx" 
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = [
      "89.175.21.0/24",
      "2.63.219.0/24"
    ]
  }

  egress {
    description    = "HTTP nginx" 
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = [
      "89.175.21.0/24",
      "2.63.219.0/24"
    ]
  }

  ingress {
    description    = "kibana-tunnel" 
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}/32"]
  }

  egress {
    description    = "kibana-tunnel" 
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}/32"]
  }
}
