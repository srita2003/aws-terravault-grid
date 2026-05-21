module "network_fabric" {
  source = "../../reusable-modules/network-fabric"
}

module "security_boundary" {
  source = "../../reusable-modules/security-boundary"

  vpc_id = module.network_fabric.vpc_id
}

module "compute_mesh" {
  source = "../../reusable-modules/compute-mesh"

  public_subnet_id = module.network_fabric.public_subnet_id

  security_group_id = module.security_boundary.security_group_id
}

module "database_layer" {
  source = "../../reusable-modules/database-layer"

  private_subnet_id = module.network_fabric.private_subnet_id

  public_subnet_id = module.network_fabric.public_subnet_id
}

module "storage_vault" {
  source = "../../reusable-modules/storage-vault"
}