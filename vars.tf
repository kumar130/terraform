variable "AWS_REGION" {
  default = "us-east-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "test"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "test.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "172.20.10.0/24"
}
