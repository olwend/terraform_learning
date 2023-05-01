variable "ami" {}

variable "instance_type" {}

variable "subnet_id" {}

variable "vpc_security_group_id" {}

variable "Identity" {}

#variable "id" {}

variable "num_webs" {
  default = 1
}

variable "availability_zone" {
  default = "eu-west-1a"
}

variable "size" {
  default = 10
}

variable "office_IPMask" {
  default = "212.250.145.34/32"
}

variable "port_for_ssh" {
  default = 22
}

variable "port_for_http" {
  default = 80
}

variable "e_from_port" {
  default = 0
}

variable "e_to_port" {
  default = 0
}
