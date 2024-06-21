pipeline {
    agent any
    environment {
        GCR_CREDENTIALS_ID = 'gcr-credentials' // The ID you provided in Jenkins credentials
        IMAGE_NAME = 'agray-lbg-api'
        GCR_URL = 'gcr.io/lbg-mea-build-c19'
        PROJECT_ID = 'lbg-mea-build-c19'
        CLUSTER_NAME = 'agray-cluster'
        LOCATION = 'europe-west2-c'
        CREDENTIALS_ID = 'gke-svc-acct'
    }
    stages {
        stage('Build and Push to GCR') {
            steps {
                script {
                    // Authenticate with Google Cloud
                    withCredentials([file(credentialsId: GCR_CREDENTIALS_ID, variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                        sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
                    }
                // Configure Docker to use gcloud as a credential helper
                sh 'gcloud auth configure-docker --quiet'
                // Build the Docker image
                sh "docker build -t ${GCR_URL}/${IMAGE_NAME}:${BUILD_NUMBER} ."
                // Push the Docker image to GCR
                sh "docker push ${GCR_URL}/${IMAGE_NAME}:${BUILD_NUMBER}"
                sh "sed -e 's,{{BUILD_NUMBER}},'${BUILD_NUMBER}',g;' kubernetes/deployment.yaml > kubernetes/deployment.yml"
                }
            }
        }
        stage('Deploy to GKE') {
            steps {
                script {
                    // Deploy to GKE using Jenkins Kubernetes Engine Plugin
                    step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'kubernetes/deployment.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
                }
            }
        }
    }
}