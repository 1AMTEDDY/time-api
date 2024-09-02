roles = {
  "logging_writer" = {
    role   = "roles/logging.logWriter"
    member = "serviceAccount:github-actions@aerobic-library-434401-h4.iam.gserviceaccount.com"
  }
  "monitoring_metric_writer" = {
    role   = "roles/monitoring.metricWriter"
    member = "serviceAccount:github-actions@aerobic-library-434401-h4.iam.gserviceaccount.com"
  }
}
