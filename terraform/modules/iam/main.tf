resource "google_project_iam_member" "project" {
  for_each = var.roles

  project = var.project_id
  role    = each.value.role
  member  = each.value.member
}
