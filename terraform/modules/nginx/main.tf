resource "kubernetes_namespace" "nginx" {
  metadata {
    annotations = {
      name = "nginx"
    }

    name = "nginx"
  }
}

resource "kubernetes_config_map" "nginx" {
  metadata {
    name = "nginx-conf"
    namespace = kubernetes_namespace.nginx.metadata.0.name
  }

  data = {
    "nginx.conf" = <<-EOT
      worker_processes 1;

      events {
        worker_connections 1024;
      }

      http {
        server {
          listen 8080;
          server_name localhost;

          location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
          }

          location /hello {
            return 200 "Hello, world!";
          }
        }
      }
    EOT
  }
}


resource "kubernetes_deployment" "hello_world" {
  metadata {
    name = "nginx"
    labels = {
      app = "nginx"
    }
    namespace = kubernetes_namespace.nginx.metadata.0.name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:alpine"

          port {
            container_port = 8080
          }

          volume_mount {
            name       = "nginx-config"
            mount_path = "/etc/nginx/nginx.conf"
            sub_path   = "nginx.conf"
          }
        }

        volume {
          name = "nginx-config"

          config_map {
            name = kubernetes_config_map.nginx.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx"
    namespace = kubernetes_namespace.nginx.metadata.0.name
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 8080
      node_port   = 30080
    }

    type = "LoadBalancer"
  }
}