terraform {
#  backend "gcs" {
#    bucket = "a-boeingfda-builds-tf-state"
#    prefix = "terraform/state/dev-tools/filemage_api"
#  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}


provider "github" {
  owner = local.owner

}


