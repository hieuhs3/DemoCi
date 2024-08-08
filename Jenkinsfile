pipeline {
    agent any

    environment {
        REGISTRY_URL = 'docker.io'
        IMAGE_NAME = 'your-username/your-image-name'
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Thay đổi URL và credentialsId cho phù hợp
                git url: 'https://github.com/hieuhs3/DemoCi.git', credentialsId: 'github-token'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Xây dựng image Docker
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Đẩy image lên Docker Hub
                    docker.withRegistry('https://' + REGISTRY_URL, 'docker-hub-credentials') {
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Deploy Docker Container') {
            steps {
                script {
                    // Chạy container Docker
                    dockerImage.run('-d -p 8080:8080')
                }
            }
        }
    }
}
