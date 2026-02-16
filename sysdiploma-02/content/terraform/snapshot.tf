resource "yandex_compute_snapshot_schedule" "snapshot" {
  name = "snapshot"
  description    = "Ежедневные копирование, ttl 7 дней"
 
    schedule_policy {
    expression = "0 1 * * *"
  }

  retention_period = "168h"

  snapshot_spec {
    description = "retention-snapshot"
  }

  disk_ids = [
    "${yandex_compute_instance.web-vm1.boot_disk[0].disk_id}",
    "${yandex_compute_instance.web-vm2.boot_disk[0].disk_id}",
    "${yandex_compute_instance.bastion.boot_disk[0].disk_id}",
    "${yandex_compute_instance.zabbix.boot_disk[0].disk_id}",
    "${yandex_compute_instance.elastic.boot_disk[0].disk_id}",
    "${yandex_compute_instance.kibana.boot_disk[0].disk_id}",
  ]
}