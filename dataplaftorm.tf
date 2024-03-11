// MySQL

resource "kubernetes_namespace" "mysql" {
  metadata {
    name = "mysql"
  }
}

resource "kubernetes_secret" "mysql-secrets" {
  metadata {
    name = "mysql-secrets"
    namespace = "mysql"
  }
  data = {
    "root-password" = "root"
  }
}

resource "kubernetes_deployment" "mysql-deployment" {
  metadata {
    name = "mysql-deployment"
    labels = {
      app = "mysql"
    }
    namespace = "mysql"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mysql"
      }
    }
    template {
        metadata {
          labels = {
            app = "mysql"
          }
        }
        spec {
          container {
            image = "mysql:8.0"
            name = "mysql"
            port {
              container_port = 3306
            }
            env {
              name = "MYSQL_PASSWORD"
              value = "password"
            }
            env {
              name = "MYSQL_DATABASE"
              value = "mysqldb"
            }
            env {
              name = "MYSQL_USER"
              value = "user"
            }
            env {
              name = "MYSQL_ROOT_PASSWORD"
              value_from {
                secret_key_ref {
                  name = "mysql-secrets"
                  key = "root-password"
                }
              }
            }
          }
        }
    }
  }
}

resource "kubernetes_service" "mysql-service" {
  metadata {
    name = "mysql-service"
    namespace = "mysql"
  } 
  spec {
    selector = {
      app = "mysql"
    }
    port {
      protocol = "TCP"
      port = 3306
      target_port = 3306
    }
  } 
}

// PhpMyAdmin

resource "kubernetes_deployment" "phpmyadmin-deployment" {
  metadata {
    name = "phpmyadmin-deployment"
    namespace = "mysql"
    labels = {
      app = "phpmyadmin"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "phpmyadmin"
      }
    }
    template {
      metadata {
        labels = {
          app = "phpmyadmin"
        }
      }
      spec {
        container {
          name = "phpmyadmin"
          image = "phpmyadmin/phpmyadmin"
          port {
            container_port = 80
          }
          env {
            name = "PMA_HOST"
            value = "mysql-service.mysql.svc.cluster.local"
          }
          env {
            name = "PMA_PORT"
            value = "3306"
          }
          env {
            name = "MYSQL_USERNAME"
            value = "root"
          }
          env {
            name = "MYSQL_ROOT_PASSWORD"
            value = "root"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "phpmyadmin-service" {
  metadata {
    name = "phpmyadmin-service"
    namespace = "mysql"
  }
  spec {
    type = "NodePort"
    selector = {
      app = "phpmyadmin"
    }
    port {
      protocol = "TCP"
      port = 3312
      target_port = 80
      node_port = 30002
    }
  }
}

resource "kubernetes_ingress_v1" "phpmyadmin-ingress" {
  metadata {
    name = "phpmyadmin-ingress"
    namespace = "mysql"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "dataplatform.phpmyadmin.io"
      http {
        path {
          path = "/"
          backend {
            service {
              name = "phpmyadmin-service"
              port {
                number = 3312
              }
            }
          }
        }
      }
    }
  }
}