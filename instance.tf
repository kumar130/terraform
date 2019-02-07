resource "aws_key_pair" "new" {
  key_name = "new"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "master" {
  ami = "ami-7ea88d1b"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.new.key_name}"
  subnet_id = "${aws_subnet.main-public.id}"
  vpc_security_group_ids = ["${aws_security_group.jmaster.id}"]
  #user_data = "${file("script.sh")}"

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
      # "sudo cat /var/lib/jenkins/secrets/initialAdminPassword >> test.txt"
    ]
  }
  connection {
    type = "ssh"
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }

  tags {
    Name = "Jenkins"
  }
}

# Defining Application server inside the private subnet
resource "aws_instance" "app" {
  ami  = "ami-7ea88d1b"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.new.key_name}"
  subnet_id = "${aws_subnet.main-private-1.id}"
  vpc_security_group_ids = ["${aws_security_group.app.id}"]
  source_dest_check = false

  provisioner "file" {
    source = "app.sh"
    destination = "/tmp/app.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/app.sh",
      "sudo /tmp/app.sh",
    ]
  }
  connection {
    type = "ssh"
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }

  tags {
    Name = "app"
  }
}
