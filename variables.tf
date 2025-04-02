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