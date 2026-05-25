output "project_name" {
  value = "aws-terravault-grid"
}

output "vpc_id" {
  value = module.network_fabric.vpc_id
}

output "public_subnet_id" {
  value = module.network_fabric.public_subnet_id
}

output "private_subnet_id" {
  value = module.network_fabric.private_subnet_id
}

output "ec2_instance_id" {
  value = module.compute_mesh.ec2_id
}

output "database_id" {
  value = module.database_layer.database_name
}

output "artifact_bucket" {
  value = module.storage_vault.artifact_bucket
}