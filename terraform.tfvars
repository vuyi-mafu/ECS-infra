aws_region   = "af-south-1"
project_name = "demo"
environment  = "prod"

vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]

container_port = 443
task_cpu       = 256
task_memory    = 512
desired_count  = 1
