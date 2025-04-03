variable "aws_region" {
  default = "us-east-1"
}

variable "instance_count" {
  default = 2
}

variable "security_groups" {
  type = map(number)
  default = {
    "web-sg" = 80
    "ssh-sg" = 22
  }
}

variable "db_password" {
  description = "Database password"
  sensitive   = true
}

variable "duplicate_subnets" {
  default = ["subnet-1", "subnet-2", "subnet-1"]
}

variable "subnet_ids" {
  default = ["subnet-1", "subnet-2", "subnet-3", "subnet-4"]
}
