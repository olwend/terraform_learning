
resource "aws_lb" "uc1-lb" {
  name               = "uc1-lb-tf"
  internal           = false
  load_balancer_type = "application"
#   security_groups    = module.security_group.this_security_group_id
  security_groups    = data.security_group.uc1-LB-ingres
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}
