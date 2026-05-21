package terraform.guardrails

deny contains msg if {
  input.resource.aws_db_instance.publicly_accessible == true

  msg := "Public database access is prohibited"
}