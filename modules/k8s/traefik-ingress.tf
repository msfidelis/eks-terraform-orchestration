resource "kubernetes_ingress" "traefik_ingress_whois" {
  metadata {
    name = "traefik-ingress-whois"

    annotations = {
      "kubernetes.io/ingress.class"               = "traefik"
      "traefik.frontend.rule.type"                =  "PathPrefixStrip"
      "traefik.ingress.kubernetes.io/rule-type"   =  "PathPrefixStrip"

    }
  }

  spec {
    backend {
      service_name = "whois"
      service_port = 8080
    }

    rule {
        host= "k8s.raj.ninja"
      http {
        path {
          path = "/whois/*"
          backend {
            service_name = "whois"
            service_port = 8080
          }
        }
      }
    }

  }
}
