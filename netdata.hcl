job "netdata" {
  type        = "service"
  datacenters = ["dc1"]
  namespace   = "default"

  update {
    max_parallel      = 1
    health_check      = "checks"
    min_healthy_time  = "10s"
    healthy_deadline  = "10m"
    progress_deadline = "12m"
    stagger           = "30s"
  }

  group "netdata" {
    network {
      mode = "bridge"
    }

    service {
      name = "pd-netdata-from-local"
      port = "19999"
      tags = ["test"]

      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "pd-postgres"
              local_bind_port = 5432
            }
          }
        }
      }
    }

    task "netdata" {
      driver = "docker"

      config {
        image = "gitlab-container-registry.minerva.loc/informasjon-analyse/leveranseteam2/infrastruktur/ws-datastack/netdata"
      }
    }
  }
}
