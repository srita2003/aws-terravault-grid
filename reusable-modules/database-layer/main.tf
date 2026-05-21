resource "aws_db_subnet_group" "vault_subnet_group" {
  name = "vault-db-subnet-group"

  subnet_ids = [
    var.private_subnet_id,
    var.public_subnet_id
  ]

  tags = {
    Name = "vault-db-subnet-group"
  }
}

resource "aws_db_instance" "persistence_engine" {
  identifier = "terravault-postgres-db"

  allocated_storage = 20

  storage_type = "gp2"

  engine = "postgres"

  engine_version = "15"

  instance_class = "db.t3.micro"

  username = "postgres"

  password = "Password123!"

  publicly_accessible = false

  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.vault_subnet_group.name

  tags = {
    Name = "persistence-engine"
  }
}