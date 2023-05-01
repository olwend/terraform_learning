# Input variable definitions

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "oed-uc1-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "vpc_private_subnet" {
  description = "Private subnet for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_public_subnet" {
  description = "Public subnet for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24","10.0.102.0/24"]
}

variable "vpc_create_igw_gateway" {
  description = "internet gateway for VPC"
  type    = bool
  default = true
}

variable "igw_tags" {
  description = "Tags to apply to igw"
  type        = map(string)
  default     = {
    Name   = "oed-uc1"
    Environment = "dev"
  }
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default     = {
    Terraform   = "true"
    Environment = "dev"
  }
}
