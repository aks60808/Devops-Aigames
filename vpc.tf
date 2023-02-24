resource "google_compute_network" "vpc_network" {
  name                    = "${var.project_id}-network"
  auto_create_subnetworks = "true"
}



resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.name
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
  depends_on = [
    google_compute_network.vpc_network
  ]
}
resource "google_compute_firewall" "http-jenkins-server" {
  name = "allow-http-jenkins"
  allow {
    ports    = ["80", "8080"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.name
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-jenkins-server"]
  depends_on = [
    google_compute_network.vpc_network
  ]
}
resource "google_compute_firewall" "allow-nodejs-site" {
  name = "allow-nodejs-site"
  allow {
    ports    = ["3000"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.name
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nodejs"]
  depends_on = [
    google_compute_network.vpc_network
  ]
}
# resource "google_compute_firewall" "jenkins" {
#   name    = "cicd-jenkins-firewall"
#   network = google_compute_network.vpc_network.id

#   allow {
#     protocol = "tcp"
#     ports    = ["8080"]
#   }
#   source_ranges = ["0.0.0.0/0"]
# }

# # Subnet
# resource "google_compute_subnetwork" "subnet" {
#   name          = "${var.project_id}-subnet"
#   region        = var.region
#   network       = google_compute_network.vpc_network.id
#   ip_cidr_range = "10.10.0.0/24"
# }