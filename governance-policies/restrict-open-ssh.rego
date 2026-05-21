package terraform.guardrails

deny contains msg if {
  input.resource.ingress[_].cidr_blocks[_] == "0.0.0.0/0"

  input.resource.ingress[_].from_port == 22

  msg := "Open SSH access detected"
}