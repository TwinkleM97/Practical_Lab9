data "aws_ssm_parameter" "amzn2_linux" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_security_group" "dynamic_sg" {
  for_each = var.security_groups
  name     = each.key
  vpc_id   = var.vpc_id

  ingress {
    from_port   = each.value
    to_port     = each.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  count                     = var.instance_count
  ami                       = data.aws_ssm_parameter.amzn2_linux.value
  instance_type             = "t3.micro"
  subnet_id                 = element(var.subnet_ids, count.index)
  vpc_security_group_ids    = [for sg in aws_security_group.dynamic_sg : sg.id]
  associate_public_ip_address = true
#   user_data = <<-EOF
#               #!/bin/bash
#               yum install -y nginx
#               systemctl start nginx
#               echo "Hello from EC2-${count.index + 1}" > /usr/share/nginx/html/index.html
#               EOF
  user_data = <<-EOF
  #!/bin/bash
  amazon-linux-extras enable nginx1
  yum clean metadata
  yum install -y nginx
  systemctl start nginx
  systemctl enable nginx
  echo "<h1>Hello from EC2-${count.index + 1}</h1>" > /usr/share/nginx/html/index.html
EOF

  tags = { Name = "WebServer-${count.index + 1}" }
}

output "public_ips" {
  value = aws_instance.web[*].public_ip
}

output "instance_ids" {
  value = aws_instance.web[*].id
}

output "sg_ids" {
  value = [for sg in aws_security_group.dynamic_sg : sg.id]
}

variable "instance_count" {}
variable "security_groups" { type = map(number) }
variable "subnet_ids" {}
variable "vpc_id" {}
