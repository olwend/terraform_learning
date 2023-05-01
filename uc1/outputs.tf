# Output variable definitions

output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.public_subnets
}

output "vpc_security_group" {
  description = "default security_group"
  value       = module.vpc.default_security_group_id
}

output "vpc_cidr" {
  description = "default public subnets cidr"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "vpc_internet_gateway" {
  description = "IDs of the igw"
  value       = module.vpc.igw_id
}

output "vpc_routes" {
  description = "route table ID"
  value       = module.vpc.default_route_table_id
}

output "lb_security_groups" {
  description = "lb security_groups"
  value = aws_lb.uc1-lb.security_groups 
}

output "ec2_instance_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = module.ec2_instances.public_ip
}

output "ec2_instance_security_groups" {
  description = "Public IP addresses of EC2 instances"
  value       = module.ec2_instances.security_groups
}

output "ec2_associated_security_groups" {
  description = "associated security groups of instances, if running in non-default VPC"
  value       = module.ec2_instances.vpc_security_group_ids
}

output "sec_group" {
  description = "security_group"
  value = module.security_group.this_security_group_id
}


