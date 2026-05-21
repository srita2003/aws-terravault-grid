resource "aws_s3_bucket" "terravault_state" {
  bucket = "terravault-state-debasrita-2026"

  tags = {
    Name = "terravault-state-bucket"
  }
}