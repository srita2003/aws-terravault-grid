resource "aws_s3_bucket" "artifact_vault" {
  bucket = "terravault-artifacts-debasrita-2026"

  tags = {
    Name = "artifact-vault"
  }
}