provider "aws" {
  #alias      = "east"
  region     = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "personal"
}
resource "aws_security_group" "sg_app" {
  name        = var.SG_APP_NAME
  description = "Security Group Name for APP Server "
  tags = {
    "Name" = "app"
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.MY_IP}"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.MY_IP}"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${var.MY_IP}"]
  }
  #ingress {
  #  from_port = 0
  #  to_port = 0
  #  protocol = "-1"
  #  security_groups = ["${aws_security_group.sg_app.id}"]
  #}
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.ALL_IP}"]
  }
}
locals { 
  #conn_host = "${self.public_ip}"
  conn_type = "ssh"
  conn_user = "ubuntu"
  conn_timeout = "1m"
  conn_key = "${file("~/Documents/ansible-aws.pem")}"
}


### INSTANCE FOR APP ###
resource "aws_instance" "app" {
  count = var.instance_count
  ami = "${lookup(var.AWS_AMIS, var.AWS_REGIONS)}"
  instance_type = var.INSTANCE_TYPE
  availability_zone = "${var.AWS_REGIONS}a"
  key_name = var.KEY_PUBLIC
  security_groups = [aws_security_group.sg_app.name]
  tags = {
    Name = "App-${count.index + 1}"
    env = "dev"
  }

  provisioner "local-exec" {
      command = "echo '[WAITING FOR INSTANCE ...]' && sleep 40"

    connection { 
      host = self.public_ip
      type = local.conn_type
      user = local.conn_user
      timeout = local.conn_timeout
      private_key = local.conn_key
    }
  }
  /*provisioner "file" {
    source      = "../../linuxtips"
    destination = "/tmp/linuxtips"
    connection { 
      host = self.public_ip
      type = local.conn_type
      user = local.conn_user
      timeout = local.conn_timeout
      private_key = local.conn_key
    }
  }*/

  provisioner "remote-exec" {
    inline = [
      "echo '[UPDATING THE SYSTEM]'",
      "sudo apt update -y",
      "sudo apt install software-properties-common -y",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y"
    ]
    connection { 
      host = self.public_ip
      type = local.conn_type
      user = local.conn_user
      timeout = local.conn_timeout
      private_key = local.conn_key
    }
  }
  /*provisioner "local-exec" {
    command = "echo ${aws_instance.app[*].public_ip} >> hosts"
  }*/
}
