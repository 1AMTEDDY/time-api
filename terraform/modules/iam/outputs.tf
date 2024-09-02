output "iam_roles" {
  value = { for k, v in var.roles : k => v.role }
}
