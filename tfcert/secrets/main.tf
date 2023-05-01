provider "aws" {
    region = "eu-west-2"
  
}

variable "username" {
    type = string
}

variable "password" {
    type = string
}

provider "vault" {
    auth_login {
        path = "auth/userpass/login/var.username"
        parameters = {
            password = var.password
        }
    }
}

provider "aws" {
    region = "eu-west-1"
    alias = "ireland"
}

data "vault_generic_secret" "authtoken" {
    path = var.vault_secret
}
resource aws_vpc ldnvpc {
    cidr_block = "10.0.0.0/16"
}

resource aws_vpc irlvpc {
    cidr_block = "10.0.0.0/16"
    provider = aws.ireland
}