provider "aws" {
    region = "eu-west-2"
}


resource aws_instance myec2 {
    ami = "ami-0b6b51e397faf2316"
    instance_type = "t2.micro"

    tags = {
        Name = "web server"
    }
}

module "dbserver" {
    source = "./db/mysql"
    dbname = "mydbserver"

}

output "dbprivateip" {
    value = module.dbserver.private_ip
}