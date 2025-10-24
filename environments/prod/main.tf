terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "local" {}
}

provider "aws" {
  region = var.aws_region

  # Mock AWS for POC demo (removes need for real credentials)
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true

  default_tags {
    tags = {
      Environment = "prod"
      ManagedBy   = "Terraform"
      Project     = var.project_name
    }
  }
}

# Variables
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "terraform-cicd-poc"
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "instance_count" {
  type = number
}

# VPC Module
module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = var.vpc_cidr
  project_name         = var.project_name
  environment          = "prod"
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# Security Group Module
module "security_group" {
  source       = "../../modules/security-group"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  environment  = "prod"
}

# EC2 Module
module "ec2" {
  source            = "../../modules/ec2"
  instance_count    = var.instance_count
  instance_type     = var.instance_type
  subnet_ids        = module.vpc.public_subnet_ids
  security_group_id = module.security_group.security_group_id
  project_name      = var.project_name
  environment       = "prod"
}

# Outputs
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "instance_ids" {
  value = module.ec2.instance_ids
}

output "instance_public_ips" {
  value = module.ec2.public_ips
}
