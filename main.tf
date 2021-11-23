# https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container

resource "random_string" "nginx" {
  length  = 8
  upper   = false
  special = false
}

resource "docker_image" "nginx" {
  name = "nginx:stable-alpine"
}

resource "docker_image" "traefik" {
  name = "traefik:1.7.14"
}

resource "docker_network" "nginx" {
  name   = "docknet"
  driver = "bridge"
}

resource "docker_container" "traefik" {
  name  = "traefik"
  image = docker_image.traefik.name

  networks_advanced {
    name    = docker_network.nginx.name
    aliases = ["docknet"]
  }

  restart = "unless-stopped"
  destroy_grace_seconds = 30
  must_run = true
  memory = 256

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  command = [
    "--api",
    "--docker",
    "--docker.watch",
    "--entrypoints=Name:http Address::80",
    "--logLevel=INFO"
  ]

  ports {
    internal = 80
    external = 80
    ip       = "0.0.0.0"
  }

  labels {
    label = "traefik.enable"
    value = true
  }

  labels {
    label = "traefik.docker.network"
    value = "docknet"
  }

  labels {
    label = "traefik.frontend.rule"
    value = "Host:traefik.${var.domain}"
  }

  labels {
    label = "traefik.port"
    value = 8080
  }

}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.name

  networks_advanced {
    name    = docker_network.nginx.name
    aliases = ["docknet"]
  }

  restart = "unless-stopped"
  destroy_grace_seconds = 30
  must_run = true
  memory = 256

  volumes {
    host_path      = "/Users/ruan/personal/terraform-playground/docker-containers/html"
    container_path = "/usr/share/nginx/html"
  }

  volumes {
    host_path      = "/Users/ruan/personal/terraform-playground/docker-containers/configs/nginx.conf"
    container_path = "/etc/nginx/nginx.conf"
  }

  volumes {
    host_path      = "/Users/ruan/personal/terraform-playground/docker-containers/configs/app.conf"
    container_path = "/etc/nginx/conf.d/app.conf"
  }

  env = [
    "PUID=501",
    "PGID=20"
  ]

  labels {
    label = "traefik.enable"
    value = true
  }

  labels {
    label = "traefik.docker.network"
    value = "docknet"
  }

  labels {
    label = "traefik.frontend.rule"
    value = "Host:www.${random_string.nginx.result}.${var.domain}"
  }

  labels {
    label = "traefik.port"
    value = 80
  }

  depends_on = [
    docker_container.traefik,
    random_string.nginx
  ]

}
