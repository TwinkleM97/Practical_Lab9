resource "aws_lb" "alb" {
  name               = "lab8-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_ids
  subnets            = var.subnet_ids
  tags = { Name = "Lab8ALB" }
}

resource "aws_lb_target_group" "tg" {
  name     = "lab8-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group_attachment" "attach" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}

output "lb_dns" {
  value = aws_lb.alb.dns_name
}

variable "subnet_ids" {}
variable "vpc_id" {}
variable "instance_count" {}
variable "instance_ids" {}
variable "sg_ids" {}
