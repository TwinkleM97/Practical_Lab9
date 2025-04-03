output "public_ips" {
  value = module.ec2.public_ips
}

output "rds_endpoint" {
  value     = module.rds.endpoint
  sensitive = true
}

output "alb_dns" {
  value = module.alb.lb_dns
}

output "joined_public_ips" {
  description = "All EC2 public IPs combined into a single comma-separated string"
  value       = join(", ", module.ec2.public_ips)
}

output "number_of_public_subnets" {
  description = "Number of public subnets created"
  value       = length(module.vpc.subnet_ids)
}

output "unique_subnets" {
  description = "Removes duplicate subnets"
  value       = distinct(var.duplicate_subnets)
}

output "first_two_subnets" {
  description = "Slices first two subnets"
  value       = slice(var.subnet_ids, 0, 2)
}

output "has_web_sg" {
  description = "Check if web-sg is present in security group map"
  value       = contains(keys(var.security_groups), "web-sg")
}
