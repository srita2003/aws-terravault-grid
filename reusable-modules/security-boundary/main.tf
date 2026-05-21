resource "aws_security_group" "boundary_guard" {
  name   = "boundary-guard"
  vpc_id = var.vpc_id

  ingress {
    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "PostgreSQL"

    from_port = 5432
    to_port   = 5432

    protocol = "tcp"

    cidr_blocks = ["172.28.0.0/16"]
  }

  egress {
    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "boundary-guard"
  }
}