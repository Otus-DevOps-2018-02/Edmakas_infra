variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-d"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path_conn {
  description = "Path to the private key used by provisioner connection"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image with mongodb for reddit"
  default     = "reddit-db-base"
}
