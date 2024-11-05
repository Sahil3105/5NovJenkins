pipeline {
    agent any

    environment {
        DOCKER_USERNAME = credentials('docker-username') // Replace with your Jenkins credential ID for Docker Hub username
        DOCKER_PASSWORD = credentials('docker-password') // Replace with your Jenkins credential ID for Docker Hub password
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Sahil3105/5NovJenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t sahil3105/my-docker-app:latest .'
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    sh 'docker run -t sahil3105/my-docker-app:latest npm install --silent'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub
                    sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh 'docker push sahil3105/my-docker-app:latest'
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    // Optionally remove the local image after pushing
                    sh 'docker rmi sahil3105/my-docker-app:latest || true'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true // Adjust this path based on your build output
            cleanWs()
        }
    }
}
