variable "AWS_REGION" {
  default = "us-east-2"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "new"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "new.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "172.20.10.0/24"
}
