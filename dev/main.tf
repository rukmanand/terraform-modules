module "dev-env-vpc" {
  source              = "../modules/vpc-networking"
  vpc_region          = "eu-west-1"
  vpc_name            = "tf-module-exmple-vpc"
  vpc_cidr            = "10.10.0.0/16"
  vpc_azs             = ["eu-west-1a", "eu-west-1b"]
  vpc_private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  vpc_public_subnets  = ["10.10.101.0/24", "10.10.102.0/24"]
}