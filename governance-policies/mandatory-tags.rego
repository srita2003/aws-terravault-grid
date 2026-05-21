package terraform.guardrails

deny contains msg if {
  not input.resource.tags.Name

  msg := "Name tag is mandatory"
}