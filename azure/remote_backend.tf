terraform {
  backend "remote" {
    organization = "DevOpsRick"

    workspaces {
      name = "azure"
    }
  }
}
