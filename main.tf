module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source          = "./modules/ec2"
  instance_count  = var.instance_count
  security_groups = var.security_groups
  subnet_ids      = module.vpc.subnet_ids
  vpc_id          = module.vpc.vpc_id
}

module "rds" {
  source      = "./modules/rds"
  db_password = var.db_password
}

module "alb" {
  source         = "./modules/alb"
  instance_count = var.instance_count
  subnet_ids     = module.vpc.subnet_ids
  vpc_id         = module.vpc.vpc_id
  instance_ids   = module.ec2.instance_ids
  sg_ids         = module.ec2.sg_ids
}
