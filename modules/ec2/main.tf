# Static AMI ID for POC demo (no AWS API call needed)
# Using Amazon Linux 2 AMI ID for us-east-1
locals {
  ami_id = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 in us-east-1 (static for POC)
}

# EC2 Instances
resource "aws_instance" "main" {
  count                  = var.instance_count
  ami                    = local.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[count.index % length(var.subnet_ids)]
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from ${var.environment} - Instance ${count.index + 1}</h1>" > /var/www/html/index.html
              EOF

  root_block_device {
    volume_size = 20
    encrypted   = true
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-instance-${count.index + 1}"
    Environment = var.environment
  }
}

# Variables
variable "instance_count" {
  type = number
}

variable "instance_type" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

# Outputs
output "instance_ids" {
  value = aws_instance.main[*].id
}

output "public_ips" {
  value = aws_instance.main[*].public_ip
}
