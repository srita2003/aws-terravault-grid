output "vpc_id" {
  value = aws_vpc.core_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.ingress_segment.id
}

output "private_subnet_id" {
  value = aws_subnet.runtime_segment.id
}