# Adding resource aws instance within the VPC
resource "aws_instance" "master" {
  ami                         = "ami-7ea88d1b"
  instance                    = "t2.micro"
  key_name                    = "mykey"
  subnet_id                   = "${aws_subnet.main-public.id}"
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = "${file("starter.sh")}"

  tags {
    Name = "master"
  }

  resource "aws_instance" "slave" {
    ami                         = "ami-7ea88d1b"
    instance                    = "t2.micro"
    subnet_id                   = "${aws_subnet.main-public.id}"
    associate_public_ip_address = true
    source_dest_check           = false

    tags {
      Name = "slave"
    }
  }
}
