variable "instances" {
  description = "values for instances"
  type        = set(string)
  default     = ["apache"]
}

resource "aws_instance" "public-instance" {
  for_each               = var.instances
  ami                    = var.ami_value
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")
  tags = {
    Name = "${each.value}-${local.sufix}"
  }
}

resource "aws_instance" "monitoring-instance" {
  count                  = var.enable_monitoring ? 1 : 0
  ami                    = var.ami_value
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World" > ~/hello.txt
              EOF
  tags = {
    Name = "monitoring-instance-${local.sufix}"
  }
}