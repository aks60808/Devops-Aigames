resource "google_compute_instance" "deployment_server" {
  name         = "aigames-deployment-server"
  machine_type = "e2-medium"
  allow_stopping_for_update = true
  tags         = ["http-jenkins-server", "ssh","nodejs"]
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

# resource "google_compute_instance" "deployment_server_2" {
#   name         = "aigames-deployment-server-2"
#   machine_type = "e2-medium"
#   allow_stopping_for_update = true
#   tags         = ["http-jenkins-server", "ssh","nodejs"]
#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }

#   network_interface {
#     network = "${var.project_id}-network"
#     access_config {
#     }
#   }
#   depends_on = [
#     google_compute_network.vpc_network
#   ]
# }