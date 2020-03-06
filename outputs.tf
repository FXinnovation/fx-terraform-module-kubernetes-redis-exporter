output "deployment_name" {
  description = "Name of the deployment created by the module."
  value       = element(concat(kubernetes_deployment.this.*.metadata.0.name, [""]), 0)
}

output "service_name" {
  description = "Name of the service created by the module."
  value       = element(concat(kubernetes_service.this.*.metadata.0.name, [""]), 0)
}

output "prometheus_alert_groups" {
  description = "List of alerts that you can import in prometheus."
  value       = var.enabled ? local.prometheus_alert_groups : []
}
