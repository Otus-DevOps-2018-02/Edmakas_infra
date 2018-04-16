variable zone {
  description = "Zone"
  default     = "europe-west1-d"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable db_disk_image {
  description = "Disk image with mongodb for reddit"
  default     = "reddit-db-base"
}
