#####
# Global
#####

variable "annotations" {
  description = "Additionnal annotations that will be merged on all resources."
  default     = {}
}

variable "enabled" {
  description = "Whether or not to enable this module."
  default     = true
}

variable "labels" {
  description = "Additionnal labels that will be merged on all resources."
  default     = {}
}

variable "namespace" {
  description = "Namespace in which the module will be deployed."
  default     = "default"
}

#####
# Prometheus
#####

variable "prometheus_alert_groups_rules_labels" {
  description = "Map of strings that will be merge on all prometheus alert groups rules labels."
  default     = {}
}

variable "prometheus_alert_groups_rules_annotations" {
  description = "Map of strings that will be merge on all prometheus alert groups rules annotations."
  default     = {}
}

#####
# Application
#####

variable "environment_variables" {
  description = "Map of key/values that will be injected as environement variables to configure redis-exporter. More information [here](https://github.com/oliver006/redis_exporter)."
  default     = {}
}

#####
# Deployment
#####

variable "deployment_annotations" {
  description = "Additionnal annotations that will be merged on the deployment."
  default     = {}
}

variable "deployment_labels" {
  description = "Additionnal labels that will be merged on the deployment."
  default     = {}
}

variable "deployment_name" {
  description = "Name of the deployment that will be create."
  default     = "redis-exporter"
}

variable "deployment_template_annotations" {
  description = "Additionnal annotations that will be merged on the deployment template."
  default     = {}
}

variable "deployment_template_labels" {
  description = "Additionnal labels that will be merged on the deployment template."
  default     = {}
}

variable "image_name" {
  description = "Name of the docker image to use."
  default     = "oliver006/redis_exporter"
}

variable "image_pull_policy" {
  description = "Image pull policy on the main container."
  default     = "IfNotPresent"
}

variable "image_version" {
  description = "Tag of the docker image to use."
  default     = "latest"
}

variable "replicas" {
  description = "Number of replicas to deploy."
  default     = 1
}

#####
# Service
#####

variable "service_annotations" {
  description = "Additionnal annotations that will be merged for the service."
  default     = {}
}

variable "service_labels" {
  description = "Additionnal labels that will be merged for the service."
  default     = {}
}

variable "service_name" {
  description = "Name of the service that will be create"
  default     = "redis-exporter"
}
