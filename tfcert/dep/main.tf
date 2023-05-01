provider "aws" {
    region = "eu-west-2"
}

resource aws_instance myec2 {
    ami = "ami-0b6b51e397faf2316"
    instance_type = "t2.micro"

    tags = {
        Name = "web server"
    }
    depends_on = [aws_instance.myec2db]
}



resource aws_instance myec2db {
    ami = "ami-0b6b51e397faf2316"
    instance_type = "t2.micro"

    tags = {
        Name = "DB server"
    }
}

data aws_instance dbsearch {
    filter {
        name = "tag:Name"
        values = ["DB server"]
    }
}

output "dbservers" {
    value = data.aws_instance.dbsearch.availability_zone
}