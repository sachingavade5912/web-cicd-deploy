pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '763062559383'
        AWS_REGION = 'ap-south-1'
        ECR_REPOSITORY_NAME = 'my-web-app'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage("Build") {
            steps {
                sh 'docker build -t ${ECR_REPOSITORY_NAME}:${IMAGE_TAG} .'
            }
        }

        stage("Push Docker Image to ECR") {
            steps {
                sh '''
                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.ap-south-1.amazonaws.com
                    docker build -t my-web-app .
                    docker tag my-web-app:latest ${AWS_ACCOUNT_ID}.dkr.ecr.ap-south-1.amazonaws.com/${ECR_REPOSITORY_NAME}:${IMAGE_TAG}
                    docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage("Deploy") {
            steps {
                sh '''
                    docker stop my-web-app || true
                    docker rm my-web-app || true
                    docker run -d --name my-web-app -p 80:80 ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${IMAGE_TAG}
                '''
            }
        }  
    }
}