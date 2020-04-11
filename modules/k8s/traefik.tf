resource "kubernetes_cluster_role" "ingress" {
  metadata {
    name = "traefik-ingress-controller"
  }

  rule {
    api_groups = [""]
    resources  = ["services", "endpoints", "secrets"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["ingresses/status"]
    verbs      = ["update"]
  }
}

resource "kubernetes_cluster_role_binding" "traefik" {
  metadata {
    name = "traefik-ingress-controller"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "traefik-ingress-controller"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "traefik-ingress-controller"
    namespace = "kube-system"
  }
}

resource "kubernetes_service_account" "traefik" {
  metadata {
    name      = "traefik-ingress-controller"
    namespace = "kube-system"
  }
}

resource "kubernetes_service" "traefik" {
  metadata {
    name = "traefik"
    namespace = "kube-system"
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
    name      = "traefik-ingress-controller"
    namespace = "kube-system"
    labels = {
      k8s-app = "traefik"
    }
  }

  spec {
    selector {
      match_labels = {
        k8s-app = "traefik"
      }
    }

    template {
      metadata {
        labels = {
          k8s-app = "traefik"
          name    = "traefik"
        }
      }

      spec {
        service_account_name = "traefik-ingress-controller"
        container {
          image = "traefik:v1.7"
          name  = "traefik-ingress-lb"

          port {
            name    = "http"
            container_port = 80
          }

          port {
            name    = "admin"
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