pipeline {
    agent any
    environment {
        // Thay đổi các biến môi trường dưới đây theo thông tin của bạn
        DOCKER_REGISTRY = 'docker.io'  // Địa chỉ Docker registry
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'  // ID của Docker Hub credentials trong Jenkins
        IMAGE_NAME = 'myapp'  // Tên Docker image của bạn
        IMAGE_TAG = 'latest'  // Thẻ Docker image của bạn
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository...'
                // Clone mã nguồn từ GitHub
                git 'https://github.com/hieuhs3/DemoCi.git'
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
        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                // Đăng nhập vào Docker Hub
                withDockerRegistry([credentialsId: "${DOCKER_CREDENTIALS_ID}", url: "${DOCKER_REGISTRY}"]) {
                    // Đẩy Docker image lên Docker Hub
                    script {
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push("${IMAGE_TAG}")
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning up...'
            // Dọn dẹp các tài nguyên hoặc làm các bước sau khi pipeline hoàn tất
            cleanWs()
        }
    }
}
