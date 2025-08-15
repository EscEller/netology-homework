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
