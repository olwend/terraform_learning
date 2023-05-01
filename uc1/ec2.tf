module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name           = "uc1-ec2-cluster"
  instance_count = 3

  ami                    = "ami-0c5204531f799e0c6"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  key_name               = "uc1-oed-key"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
