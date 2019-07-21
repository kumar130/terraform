resource "aws_key_pair" "new" {
  key_name = "test"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "master" {
  ami = "ami-0f01fcbe971af8f5a"
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
   ami  = "ami-0f01fcbe971af8f5a"
   instance_type = "t2.micro"
   key_name = "${aws_key_pair.new.key_name}"
   subnet_id = "${aws_subnet.main-private-1.id}"
   vpc_security_group_ids = ["${aws_security_group.app.id}"]
   source_dest_check = false

  tags {
    Name = "app"
  }
}
