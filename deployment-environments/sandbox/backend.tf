terraform {
  backend "s3" {
    bucket         = "terravault-state-debasrita-2026"
    key            = "sandbox/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terravault-lock-ledger"
    encrypt        = true
  }
}