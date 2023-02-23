provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}



resource "google_compute_instance" "cicd_server" {
  name         = "aigames-cicd-server"
  machine_type = "e2-medium"
  allow_stopping_for_update = true
  tags         = ["http-jenkins-server", "ssh"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "${var.project_id}-network"
    access_config {
    }
  }
  depends_on = [
    google_compute_network.vpc_network
  ]
}


resource "google_storage_bucket" "backup_bucket" {
  name          = "${var.project_id}-jenkins-backup-bucket"
  location      = "AUSTRALIA-SOUTHEAST1"
  force_destroy = true
  lifecycle_rule {
    condition {
      age = 2
    }
    action {
      type = "Delete"
    }
  }
  public_access_prevention = "enforced"
}

variable "zone" {}
variable "region" {}
variable "project_id" {}
variable "private_key_path" {}
variable "ssh_user" {}
