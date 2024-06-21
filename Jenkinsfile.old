pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "lbg"
        PORT = "9000"
        DOCKER_CREDS = credentials('dockerhub')
    }
    stages {
        stage('Cleanup') {
            steps {
                sh '''
                sh setup.sh
                '''
            }
        }
        stage('Build') {
            steps {
                sh '''
                sh build.sh
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                sh deploy.sh
                '''
            }
        }
        stage('Push to dockerhub') {
            steps {
                sh '''
                docker login -u $DOCKER_CREDS_USR -p $DOCKER_CREDS_PSW
                docker push $DOCKER_CREDS_USR/$DOCKER_IMAGE
                docker logout
                '''
            }
        }
    }
}
