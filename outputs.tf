# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

# ECR Outputs
output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

output "ecr_repository_name" {
  description = "ECR repository name"
  value       = module.ecr.repository_name
}

# ECS Outputs
output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = module.ecs.service_name
}

output "ecs_task_definition_family" {
  description = "ECS task definition family"
  value       = module.ecs.task_definition_family
}

output "container_name" {
  description = "Container name"
  value       = module.ecs.container_name
}

# ALB Outputs
output "alb_url" {
  description = "Application URL"
  value       = module.vpc.alb_url
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.vpc.alb_dns_name
}

# IAM Outputs
output "task_execution_role_arn" {
  description = "Task execution role ARN"
  value       = module.iam.execution_role_arn
}

# Log Group
output "log_group_name" {
  description = "CloudWatch log group name"
  value       = module.ecs.log_group_name
}
