#####
# Locals
#####

locals {
  labels = {
    "app.kubernetes.io/version"    = var.image_version
    "app.kubernetes.io/component"  = "exporter"
    "app.kubernetes.io/part-of"    = "monitoring"
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/name"       = "redis-exporter"
  }
  port               = 9121
  grafana_dashboards = []
  prometheus_alert_groups = [
    {
      "name" = "redis-exporter"
      "rules" = [
        {
          "alert" = "RedisExporterScrapeErrors"
          "expr"  = "redis_exporter_last_scrape_error > 0"
          "for"   = "2m"
          "labels" = {
            "severity" = "critical"
            "urgency"  = "2"
          }
          "annotations" = {
            "summary"     = "Redis Exporter - Scrape Error on {{ $labels.instance }}"
            "description" = "Redis Exporter:\n {{ $labels.instance }} has a scrape error.\nLabels:\n{{ $labels }}"
          }
        },
        {
          "alert" = "RedisExpoterScrapeDurationError"
          "expr"  = "deriv(redis_exporter_last_scrape_duration_seconds[2m]) > 0.2 and redis_exporter_last_scrape_duration_seconds > 10"
          "for"   = "5m"
          "labels" = {
            "severity" = "warning"
            "urgency"  = "3"
          }
          "annotations" = {
            "summary"     = "Redis Exporter - Scrape Duration Error on {{ $labels.instance }}",
            "description" = "Redis Exporter:\n {{ $labels.instance }} scrape duration is too high and is climbing.\nLabels:\n{{ $labels }}"
          }
        }
      ]
    },
    {
      "name" = "redis"
      "rules" = [
        {
          "alert" = "RedisDown"
          "expr"  = "redis_up < 1"
          "for"   = "1m"
          "labels" = {
            "serverity" = "critical"
            "urgency"   = "2"
          }
          "annotations" = {
            "summary"     = "Redis - Redis Instance {{ $labels.instance }} is down."
            "description" = "Redis:\n Redis instance {{ $labels.instance }} is down.\nLabels:\n{{ $labels }}"
          }
        }
      ]
    }
  ]
}

#####
# Randoms
#####

resource "random_string" "selector" {
  special = false
  upper   = false
  number  = false
  length  = 8
}

#####
# Deployment
#####

resource "kubernetes_deployment" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.deployment_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.deployment_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.deployment_name
      },
      local.labels,
      var.labels,
      var.deployment_labels
    )
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app    = "redis-exporter"
        random = random_string.selector.result
      }
    }
    template {
      metadata {
        annotations = merge(
          var.annotations,
          var.deployment_template_annotations
        )
        labels = merge(
          {
            "app.kubernetes.io/instance" = var.deployment_name
            app                          = "redis-exporter"
            random                       = random_string.selector.result
          },
          local.labels,
          var.labels,
          var.deployment_template_labels
        )
      }
      spec {
        container {
          name              = "redis-exporter"
          image             = "${var.image_name}:${var.image_version}"
          image_pull_policy = var.image_pull_policy

          dynamic "env" {
            for_each = var.environment_variables

            content {
              name  = env.key
              value = env.value
            }
          }

          readiness_probe {
            http_get {
              path   = "/"
              port   = local.port
              scheme = "HTTP"
            }

            timeout_seconds   = 5
            period_seconds    = 5
            success_threshold = 1
            failure_threshold = 35
          }

          liveness_probe {
            http_get {
              path   = "/"
              port   = local.port
              scheme = "HTTP"
            }

            timeout_seconds   = 5
            period_seconds    = 10
            success_threshold = 1
            failure_threshold = 3
          }

          port {
            name           = "http"
            container_port = local.port
            protocol       = "TCP"
          }

          resources {
            requests {
              memory = "32Mi"
              cpu    = "5m"
            }
            limits {
              memory = "64Mi"
              cpu    = "20m"
            }
          }
        }
      }
    }
  }
}


#####
# Service
#####

resource "kubernetes_service" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.service_name
    namespace = var.namespace
    annotations = merge(
      {
        "prometheus.io/scrape" = "true"
      },
      var.annotations,
      var.service_annotations
    )
    labels = merge(
      {
        "app.kubernetes.io/instance" = var.service_name
      },
      local.labels,
      var.labels,
      var.service_labels
    )
  }

  spec {
    selector = {
      random = random_string.selector.result
      app    = "redis-exporter"
    }
    type = "ClusterIP"
    port {
      port        = 80
      target_port = "http"
      protocol    = "TCP"
      name        = "http"
    }
  }
}
