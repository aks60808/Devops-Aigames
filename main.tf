# store terraform states on terraform cloud
terraform {
  cloud {
    # replace with your organization
    organization = "aks60808"

    workspaces {
    # replace with your workspace name
      name = "Aigames-workspace"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

