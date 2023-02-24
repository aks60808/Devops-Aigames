output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "cicd_server_ip" {
  value       = google_compute_instance.cicd_server.network_interface.0.access_config.0.nat_ip
  description = "cicd server ip"
}


output "jenkins_backup_bucket" {
  value       = google_storage_bucket.backup_bucket.name
  description = "jenkins backup buckets"
}

output "deployment_server_ip" {
  value       = google_compute_instance.deployment_server.network_interface.0.access_config.0.nat_ip
  description = "deployment server ip"
}