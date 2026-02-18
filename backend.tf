terraform {
  backend "s3" {
    bucket         = "ecs-terraform-state-production-bucket"
    key            = "ecs-infra/terraform.tfstate"
    region         = "af-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
