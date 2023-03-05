# store terraform states on terraform cloud
terraform {
  cloud {
    # replace with your organization
    organization = "aks60808"

    workspaces {
    # replace with your workspace name
      name = "build-from-scratch"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

