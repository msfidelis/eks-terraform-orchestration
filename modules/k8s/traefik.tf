resource "kubernetes_service" "traefik" {
  metadata {
    name = "traefik"
  }
  spec {
    selector = {
      app = "traefik"
    }

    port {
      name        = "http"
      port        = 80
      target_port = 80
    }

    port {
      name        = "admin"
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_daemonset" "traefik" {
    
  metadata {
    name      = "traefik"
    labels = {
      app = "traefik"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "traefik"
      }
    }

    template {
      metadata {
        labels = {
          app = "traefik"
        }
      }

      spec {
        container {
          image = "traefik:v1.7"
          name  = "traefik-ingress-lb"

          port {
            container_port = 80
          }

          port {
            container_port = 8080
          }

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


        }
      }
    }
  }
}