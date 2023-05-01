module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  public_subnets  = var.vpc_public_subnet
  igw_tags = var.igw_tags
  tags = var.vpc_tags
}

# create a security_group to attach to load balancer

# module "security_group" {
#   source  = "terraform-aws-modules/security-group/aws"
# #   version = "~> 3.0"

#   name        = "uc1-LB-ingress"
#   description = "Sec group for LB forwarding to EC2 instance"
#   vpc_id      = data.aws_vpc.oed-uc1-vpc.id

#   ingress_cidr_blocks = ["0.0.0.0/0"]
#   ingress_rules       = ["http-80-tcp"]
#   egress_rules        = ["all-all"]
# }

# rule to allow only ingress from LB security_group

# resource "aws_security_group_rule" "vpc-LB-only" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   source_security_group_id = data.security_group.uc1-LB-ingress
#   security_group_id = module.vpc.default_security_group_id
# }