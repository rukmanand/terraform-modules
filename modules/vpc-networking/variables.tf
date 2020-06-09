# Input variable definitions

variable "vpc_region" {
  description = "Region of VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type    = bool
  default = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default     = {
    Project   = "terraform-example"
    Environment = "dev"
  }
}