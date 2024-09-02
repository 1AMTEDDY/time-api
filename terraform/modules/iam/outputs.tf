output "iam_roles" {
  value = google_project_iam_member.project[*].role
}
