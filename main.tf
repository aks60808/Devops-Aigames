provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}



resource "google_compute_instance" "vm_instance" {
  name         = "tommy-vm-1"
  machine_type = "e2-micro"
  tags         = ["http-server"]
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y nginx; sudo nginx"
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


data "google_client_openid_userinfo" "me" {
}

resource "google_os_login_ssh_public_key" "default" {
  user = data.google_client_openid_userinfo.me.email
  project = var.project_id
  key  = file("~/.ssh/id_rsa.pub") # path/to/ssl/id_rsa.pub
}


