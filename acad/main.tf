resource "aws_instance" "ec2" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_id}", "${aws_security_group.traffic.id}"]
  key_name               = "${aws_key_pair.training.key_name}"
  count                  = "${var.num_webs}"
	availability_zone 		 = "${var.availability_zone}"

  tags = {
    "Identity" = "${var.Identity}"
    "Name"     = "Olwen ${count.index+1} / ${var.num_webs}"
    "Project"  = "Steptribe"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source      = "assets"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sh /tmp/assets/setup-web.sh",
    ]
  }
}

resource "aws_security_group" "traffic" {
  name        = "control_traffic"
  description = "Allow TLS inbound traffic"

  vpc_id      = "vpc-00e3bf973de77d348"

  // SSH
  ingress {
    # TLS (change to whatever ports you need)
    from_port = "${var.port_for_ssh}"
    to_port   = "${var.port_for_ssh}"
    protocol  = "tcp"

    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["${var.office_IPMask}"]
  }

  // HTTP
  ingress {
    # TLS (change to whatever ports you need)
    from_port = "${var.port_for_http}"
    to_port   = "${var.port_for_http}"
    protocol  = "tcp"

    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

 
  // Egress
  egress {
    from_port   = "${var.e_from_port}"
    to_port     = "${var.e_to_port}"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "training" {
  key_name   = "${var.Identity}-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

#creates volume
resource "aws_ebs_volume" "usecase" {
  count             = "${var.num_webs * 2}"
  availability_zone = "${var.availability_zone}"
  size              = "${var.size}"
}

/*
resource "aws_volume_attachment" "ebs_att" {
  count       = "${var.num_webs}"
  device_name = "/dev/sdh"- change to increase the append
  volume_id   = "${aws_ebs_volume.usecase.[count].id}"
  instance_id = "${aws_instance.ec2.*.id[count.index]}"
}
*/
#attaches volumes to each instance
resource "aws_volume_attachment" "1" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.usecase.0.id}"
  instance_id = "${aws_instance.ec2.0.id}"
}

resource "aws_volume_attachment" "2" {
  device_name = "/dev/sdi"
  volume_id   = "${aws_ebs_volume.usecase.1.id}"
  instance_id = "${aws_instance.ec2.0.id}"
}
resource "aws_volume_attachment" "3" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.usecase.2.id}"
  instance_id = "${aws_instance.ec2.1.id}"
}
resource "aws_volume_attachment" "4" {
  device_name = "/dev/sdi"
  volume_id   = "${aws_ebs_volume.usecase.3.id}"
  instance_id = "${aws_instance.ec2.1.id}"
}
resource "aws_volume_attachment" "5" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.usecase.4.id}"
  instance_id = "${aws_instance.ec2.2.id}"
}
resource "aws_volume_attachment" "6" {
  device_name = "/dev/sdi"
  volume_id   = "${aws_ebs_volume.usecase.5.id}"
  instance_id = "${aws_instance.ec2.2.id}"
}

output "public_ip" {
  value = "${aws_instance.ec2.*.public_ip}"
}
