output "nginx_container_name" {
  value = docker_container.nginx.name
}

output "traefik_container_name" {
  value = docker_container.traefik.name
}

output "traefik_url" {
  value = "http://traefik.${var.domain}/"
}

output "nginx_url" {
  value = "http://www.${random_string.nginx.result}.${var.domain}/"
}
