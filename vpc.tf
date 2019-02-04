# Internet VPC
resource "aws_vpc" "main" {
    cidr_block = "172.20.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "main"
    }
}

# Subnets
resource "aws_subnet" "main-public" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "172.20.10.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2a"

    tags {
        Name = "main-public-1"
    }
}

resource "aws_subnet" "main-private-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "172.20.20.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2a"

    tags {
        Name = "main-private-1"
    }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "main"
    }
}

# route tables
resource "aws_route_table" "main-public" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main-gw.id}"
    }

    tags {
        Name = "main-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "main-public" {
    subnet_id = "${aws_subnet.main-public.id}"
    route_table_id = "${aws_route_table.main-public.id}"
}

resource "aws_security_group" "jmaster" {
  name = "vpc_test_web"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.vpc.id}"

  tags {
    Name = "Jenkins"
  }
}

# Defining security group for private subnet
resource "aws_security_group" "jslave"{
  name = "sg_test_web"
  description = "Allow traffic from public subnet"

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }

  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "Internal"
  }
}
