# terraform-docker-container-example
Docker Provider example using Terraform


## Usage

Terraform Deployment:

```
terraform init
terraform plan -out=tfplan
terraform apply -auto-approve "tfplan"

docker_image.traefik: Creating...
docker_image.nginx: Creating...
docker_network.nginx: Creating...
docker_network.nginx: Creation complete after 2s [id=a54b8a9620a464568482f956c70985e5a55548a58f89083aced1b49ee5ecbfcc]
docker_image.nginx: Still creating... [10s elapsed]
docker_image.traefik: Still creating... [10s elapsed]
docker_image.nginx: Creation complete after 12s [id=sha256:373f8d4d4c60c0ec2ad5aefe46e4bbebfbb8e86b8cf4263f8df9730bc5d22c11nginx:stable-alpine]
docker_image.traefik: Still creating... [20s elapsed]
docker_image.traefik: Creation complete after 24s [id=sha256:f12ee21b2b87282bdadd113b93cceb19b03f92f21978986c5e3ff4c4ce705d54traefik:1.7.14]
docker_container.traefik: Creating...
docker_container.traefik: Creation complete after 1s [id=2ac522f6af70cb77bea4cf45cd4b462ddaf13e0e17fc5931e8f3ee88edc2f577]
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=4422769b179b66a9cb6d314f6944895788fc3f85170b49f0451f2074317d86c0]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
```

View the containers:

```
docker ps

CONTAINER ID   IMAGE                  COMMAND                  CREATED              STATUS                PORTS                NAMES
4422769b179b   nginx:stable-alpine    "/docker-entrypoint.…"   About a minute ago   Up About a minute     80/tcp               nginx
2ac522f6af70   traefik:1.7.14         "/traefik --api --do…"   About a minute ago   Up About a minute     0.0.0.0:80->80/tcp   traefik
```

Traefik:

<img width="1606" alt="image" src="https://user-images.githubusercontent.com/567298/142914876-8ebefd47-88c1-4418-a36a-e3072a95d858.png">

Nginx:

<img width="1242" alt="image" src="https://user-images.githubusercontent.com/567298/142914995-32e4a221-e312-47b2-999f-0bac09652679.png">

Destroy:

```
terraform destroy -auto-approve

docker_image.nginx: Refreshing state... [id=sha256:373f8d4d4c60c0ec2ad5aefe46e4bbebfbb8e86b8cf4263f8df9730bc5d22c11nginx:stable-alpine]
docker_image.traefik: Refreshing state... [id=sha256:f12ee21b2b87282bdadd113b93cceb19b03f92f21978986c5e3ff4c4ce705d54traefik:1.7.14]
docker_network.nginx: Refreshing state... [id=a54b8a9620a464568482f956c70985e5a55548a58f89083aced1b49ee5ecbfcc]
docker_container.traefik: Refreshing state... [id=2ac522f6af70cb77bea4cf45cd4b462ddaf13e0e17fc5931e8f3ee88edc2f577]
docker_container.nginx: Refreshing state... [id=4422769b179b66a9cb6d314f6944895788fc3f85170b49f0451f2074317d86c0]
docker_container.nginx: Destroying... [id=4422769b179b66a9cb6d314f6944895788fc3f85170b49f0451f2074317d86c0]
docker_container.nginx: Destruction complete after 0s
docker_image.nginx: Destroying... [id=sha256:373f8d4d4c60c0ec2ad5aefe46e4bbebfbb8e86b8cf4263f8df9730bc5d22c11nginx:stable-alpine]
docker_container.traefik: Destroying... [id=2ac522f6af70cb77bea4cf45cd4b462ddaf13e0e17fc5931e8f3ee88edc2f577]
docker_image.nginx: Destruction complete after 0s
docker_container.traefik: Destruction complete after 0s
docker_image.traefik: Destroying... [id=sha256:f12ee21b2b87282bdadd113b93cceb19b03f92f21978986c5e3ff4c4ce705d54traefik:1.7.14]
docker_network.nginx: Destroying... [id=a54b8a9620a464568482f956c70985e5a55548a58f89083aced1b49ee5ecbfcc]
docker_image.traefik: Destruction complete after 0s
docker_network.nginx: Destruction complete after 2s

Destroy complete! Resources: 5 destroyed.
```
