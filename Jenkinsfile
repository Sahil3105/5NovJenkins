pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'sahil3105' // Replace with your Docker Hub username
        DOCKER_IMAGE = "my-docker-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Sahil3105/5NovJenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    docker.image("${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest").inside {
                        sh 'npm install --only=dev' // Ensure dev dependencies are installed
                        sh 'npm test' // Run tests inside Docker container
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                            docker.image("${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest").push()
                        }
                    }
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh "docker rmi ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest"
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/*.log', allowEmptyArchive: true // Adjust based on generated artifacts
        }
    }
}
