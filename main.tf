
terraform {
  cloud {
    organization = var.tf_cloud_organization

    workspaces {
      name = var.tf_cloud_workspace
    }
  }
}


variable "tf_cloud_organization" {}

variable "tf_cloud_workspace" {}