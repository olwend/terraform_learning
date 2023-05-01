terraform {
  required_version = ">= 0.13.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    region = "us-west-2"
}

#   add user_data for apache provisioner 
locals {
    user_data = <<-EOF
            #!/bin/bash
            sudo su
            yum -y install httpd
            echo <h2>This is my instance</h2> >> /var/www/html/index.html
            sudo systemctl enable httpd
            sudo systemctl start httpd
            EOF

}

data "aws_vpc" "oed-uc1-vpc" {
   default = true
}

data "security_group" "uc1-LB-ingress" {
   default = true
}







