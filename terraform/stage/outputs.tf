output "app_external_ip" {
  value = "${module.app.app_external_ip }"
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
