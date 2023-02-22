provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "cicd_server" {
  name         = "aigames-cicd-server"
  machine_type = "e2-small"
  tags         = ["http-server"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }

  provisioner "remote-exec" {
    inline = ["curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-11-jre",
      "sudo apt-get install -y jenkins",
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("~/.ssh/id_rsa")
      host        = google_compute_instance.cicd_server.network_interface.0.access_config.0.nat_ip
    }

  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}



resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "jenkins" {
  name    = "cicd-jenkins-firewall"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  source_ranges = ["0.0.0.0/0"]
}




variable "zone" {}
variable "region" {}
variable "project_id" {}
variable "private_key_path" {}
variable "ssh_user" {}