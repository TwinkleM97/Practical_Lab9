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