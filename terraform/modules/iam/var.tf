variable "project_id" {}
variable "roles" {
  type = map(object({
    role   = string
    member = string
  }))
}
