
variable "dbname" {
    type = string
}

resource aws_instance myec2db {
    ami = "ami-0b6b51e397faf2316"
    instance_type = "t2.micro"

    tags = {
        Name = var.dbname
    }
}