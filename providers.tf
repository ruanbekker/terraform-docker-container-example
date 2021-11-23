terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
    random = {
      version = "~> 3.0"
    }
  }
}

# https://github.com/kreuzwerker/terraform-provider-docker
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "random" {}
