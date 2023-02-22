
terraform {
  cloud {
    organization = "aks60808"

    workspaces {
      name = "Aigames-workspace"
    }
  }
}

# resource "google_storage_bucket" "default" {
#   name          = "aks60808-aigames-bucket-tfstate"
#   force_destroy = false
#   location      = "US"
#   storage_class = "STANDARD"
#   versioning {
#     enabled = true
#   }
# }