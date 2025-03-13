resource "docker_image" "goals_backend" {
  name         = "harshankbansal/goals-backend:prod"
  keep_locally = false
}

resource "docker_image" "goals_frontend" {
  name         = "harshankbansal/goals-frontend:prod"
  keep_locally = false
}


resource "docker_network" "goals_app_network" {
  name = "goals-app-network"
  driver = "overlay"
}

resource "docker_service" "goals_backend_service" {
  name = "backend"
  mode {
    replicated {
      replicas = 2
    }
  }
  task_spec {
    networks_advanced {
      name = docker_network.goals_app_network.id
    }
    container_spec {
      image = docker_image.goals_backend.image_id
      env = {
        MONGO_USERNAME = "${var.mongo_db_username}"
        MONGO_PASSWORD = "${var.mongo_db_password}"
        MONGO_HOST = "${var.mongo_db_host}"
      } 
    } 
  }
  endpoint_spec {
    ports {
      target_port = 80
      published_port = 3000
    }
  }
}

resource "docker_service" "goals_frontend_service" {
  name = "frontend"
  mode {
    replicated {
      replicas = 1
    }
  }
  task_spec {
    networks_advanced {
      name = docker_network.goals_app_network.id
    }
    container_spec {
      image = docker_image.goals_frontend.image_id
    }
  }
  endpoint_spec {
    ports {
      target_port = 80
      published_port = 80
    }
  }
}
