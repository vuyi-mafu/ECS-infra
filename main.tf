terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # backend "s3" {
  #   bucket         = "ecs-terraform-state-686739640894"
  #   key            = "ecs-demo/terraform.tfstate"
  #   region         = "af-south-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

#########################################
# Module: VPC
#########################################

module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = data.aws_availability_zones.available.names
  container_port       = var.container_port
}

#########################################
# Module: ECR
#########################################

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
}

#########################################
# Module: IAM
#########################################

module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
}

#########################################
# Module: ECS
#########################################

module "ecs" {
  source = "./modules/ecs"

  project_name          = var.project_name
  environment           = var.environment
  aws_region            = var.aws_region
  container_port        = var.container_port
  task_cpu              = var.task_cpu
  task_memory           = var.task_memory
  desired_count         = var.desired_count

  # From VPC module
  public_subnet_ids     = module.vpc.public_subnet_ids
  ecs_security_group_id = module.vpc.ecs_security_group_id
  target_group_arn      = module.vpc.target_group_arn
  alb_listener_arn      = module.vpc.alb_listener_arn

  # From ECR module
  ecr_repository_url    = module.ecr.repository_url

  # From IAM module
  execution_role_arn    = module.iam.execution_role_arn
  task_role_arn         = module.iam.task_role_arn
}
