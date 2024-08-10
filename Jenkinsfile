pipeline {
    agent any
    environment {
        // Thay đổi các biến môi trường dưới đây theo thông tin của bạn
        DOCKER_REGISTRY = 'docker.io'  // Địa chỉ Docker registry
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'  // ID của Docker Hub credentials trong Jenkins
        IMAGE_NAME = 'myapp'  // Tên Docker image của bạn
        IMAGE_TAG = 'latest'  // Thẻ Docker image của bạn
        COMPOSE_FILE = 'docker-compose.yml'
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                // Clone mã nguồn từ GitHub
                git url: 'https://github.com/hieuhs3/DemoCi.git', branch: 'main'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                // Xây dựng Docker image từ Dockerfile
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
        stage('Run Docker Image') {
            steps {
                echo 'Run Docker image...'
                // Xây dựng Docker image từ Dockerfile
                script {
                     docker.image("${IMAGE_NAME}:${IMAGE_TAG}").withRun('-d -p 8084:8080') {
                       echo 'Running'
                    }
                }
            }
        }
        
    }
     post {
        always {
            echo 'Cleaning up...'
            cleanWs()
        }
    }
}