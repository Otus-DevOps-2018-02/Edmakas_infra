output "app_external_ip" {
  value = "${google_compute_instance.app.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "ssh_pub" {
  value = "${var.public_key_path}"
}

output "private_key_path_conn" {
  value = "${var.private_key_path_conn}"
}

output "region" {
  value = "${var.region}"
}
