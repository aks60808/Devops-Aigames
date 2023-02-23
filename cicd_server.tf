provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}



resource "google_compute_instance" "cicd_server" {
  name         = "aigames-cicd-server"
  machine_type = "e2-small"
  tags         = ["http-jenkins-server","ssh"]
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


variable "zone" {}
variable "region" {}
variable "project_id" {}
variable "private_key_path" {}
variable "ssh_user" {}
