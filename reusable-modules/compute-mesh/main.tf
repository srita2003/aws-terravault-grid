resource "aws_instance" "gateway_node" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t3.micro"

  subnet_id = var.public_subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "gateway-node"
  }
}