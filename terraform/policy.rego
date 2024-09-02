package tfplan

deny[msg] {
  input.resource_changes[_].type == "google_compute_firewall"
  firewall_rule := input.resource_changes[_].change.after

  # Blocked ports that should not be exposed to the internet
  blocked_ports := {"22", "8080"}

  # Allow ports for the API
  allowed_ports := {"80"}

  cidr_block := firewall_rule.source_ranges[_]
  ports := firewall_rule.allow[_].ports[_]

  # Block any blocked ports exposed to 0.0.0.0/0
  cidr_block == "0.0.0.0/0"
  ports[_] == blocked_ports[_]

  msg = sprintf("Public access to port %s is not allowed", [ports[_]])
}

allow[msg] {
  input.resource_changes[_].type == "google_compute_firewall"
  firewall_rule := input.resource_changes[_].change.after

  allowed_ports := {"80", "443"}  # Allow HTTP and HTTPS

  cidr_block := firewall_rule.source_ranges[_]
  ports := firewall_rule.allow[_].ports[_]

  cidr_block == "0.0.0.0/0"
  ports[_] == allowed_ports[_]

  msg = sprintf("Public access to port %s is allowed", [ports[_]])
}
