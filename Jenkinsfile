pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'sahil3105' // Replace with your Docker Hub username
        DOCKER_IMAGE = "my-docker-app"
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
                    docker.build("${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    docker.image("${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest").inside {
                        sh 'npm test'
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKER_PASSWORD')]) {
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
            archiveArtifacts artifacts: '**/*.log', allowEmptyArchive: true // Adjust to your artifact type, if any
        }
    }
}
