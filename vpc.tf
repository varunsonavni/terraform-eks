provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name                 = "${var.cluster_name}_${var.env}"
  cidr                 = "${var.vpc_cidr}"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = "${var.vpc_private_subnets}"
  public_subnets       = "${var.vpc_public_subnets}"
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}-${var.env}" = "${var.env}"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}-${var.env}" = "${var.env}"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}-${var.env}" = "${var.env}"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

