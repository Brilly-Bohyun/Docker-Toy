terraform {
  required_providers {
    docker = {
        source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_image" "prometheus" {
  name = "prometheus:1.0"
  keep_locally = false # 이미지 중복 다운로드 방지
}

resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
  keep_locally = false
}

resource "docker_image" "jenkins" {
  name = "jenkins:1.0"
  keep_locally = false
}

resource "docker_image" "influxDB" {
  name = "influxdb:1.0"
  keep_locally = false
}

resource "docker_container" "prometheus" {
  image = docker_image.prometheus.image_id
  name = "prometheus"
  ports {
    internal = 9090
    external = 9090
  }
}

resource "docker_container" "grafana" {
  image = docker_image.grafana.image_id
  name = "grafana"
  ports {
    internal = 3000
    external = 3000
  }
}

resource "docker_container" "jenkins" {
  image = docker_image.jenkins.image_id
  name = "jenkins"
  ports {
    internal = 8080
    external = 8080
  }
}

resource "docker_container" "influxDB" {
  image = docker_image.influxDB.image_id
  name = "influxDB"
  ports {
    internal = 8086
    external = 8086
  }
}