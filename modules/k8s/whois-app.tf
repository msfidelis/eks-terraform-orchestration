resource "kubernetes_service" "whois" {
  metadata {
    name = "whois"

    labels = {
    }
  }
  spec {
    selector = {
      app = "whois"
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_deployment" "whois" {
  metadata {
    name = "whois"
    labels = {
      app = "whois"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "whois"
      }
    }

    template {
      metadata {
        labels = {
          app = "whois"
        }
      }

      spec {
        container {
          image = "msfidelis/whois:v1"
          name  = "whois"

          port {
            container_port = 8080
          }

          image_pull_policy = "Always"

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/healthcheck"
              port = 8080

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 10
          }
        }
      }
    }
  }
}