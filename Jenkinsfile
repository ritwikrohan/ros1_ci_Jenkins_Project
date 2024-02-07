pipeline {
    agent any 
    stages {
        stage('Print + list current directory') {
            steps {
                sh 'pwd'
                sh 'ls -al'
            }
        }
          stage('Show ROS environment variables') {
            steps {
                sh 'env | grep ROS'
            }
        }
        stage('Install Docker') {
            steps {
                sh 'sudo apt-get update'
                sh 'sudo apt-get install -y docker.io docker-compose'
                sh 'sudo service docker start'
                sh 'sudo usermod -aG docker $USER'
                sh 'newgrp docker'
            }
        }
        stage('Start Docker Compose') {
            steps {
                sh 'cd ~/catkin_ws/src/ros1_ci'
                sh 'docker-compose up -d'
            }
        }
        stage('Done') {
            steps {
                sleep 5
                echo 'Pipeline completed'
            }
        }
    }
}
