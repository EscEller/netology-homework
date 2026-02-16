output "bastion" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}

output "zabbix" {
  value = yandex_compute_instance.zabbix.network_interface.0.nat_ip_address
}

output "kibana" {
  value = yandex_compute_instance.kibana.network_interface.0.nat_ip_address
}

output "elastic" {
  value = yandex_compute_instance.elastic.network_interface.0.ip_address
}

output "web-vm1" {
  value = yandex_compute_instance.web-vm1.network_interface.0.ip_address
}

output "web-vm2" {
  value = yandex_compute_instance.web-vm2.network_interface.0.ip_address
}

output "external_ip_address_L7balancer" {
  value = yandex_alb_load_balancer.alb.listener.0.endpoint.0.address.0.external_ipv4_address
}

output "FQDN-bastion" {
  value = yandex_compute_instance.bastion.fqdn
}

output "FQDN-web-vm1" {
  value = yandex_compute_instance.web-vm1.fqdn
}

output "FQDN-web-vm2" {
  value = yandex_compute_instance.web-vm2.fqdn
}

output "FQDN-zabbix" {
  value = yandex_compute_instance.zabbix.fqdn
}

output "FQDN-kibana" {
  value = yandex_compute_instance.kibana.fqdn
}

output "FQDN-elastic" {
  value = yandex_compute_instance.elastic.fqdn
}