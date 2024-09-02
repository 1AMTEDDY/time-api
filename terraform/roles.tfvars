roles = {
  "logging_writer" = {
    role   = "roles/logging.logWriter"
    member = "serviceAccount:github-actions@banded-arch-380523.iam.gserviceaccount.com"
  }
  "monitoring_metric_writer" = {
    role   = "roles/monitoring.metricWriter"
    member = "serviceAccount:github-actions@banded-arch-380523.iam.gserviceaccount.com"
  }
}
