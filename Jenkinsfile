// Jenkins Pipeline — Ruslan Omargali (IT2-2309), Job: Omargali_Ruslan_DevOps
pipeline {
    agent any

    environment {
        STUDENT_NAME    = 'Ruslan'
        STUDENT_SURNAME = 'Omargali'
        STUDENT_GROUP   = 'IT2-2309'
        STUDENT_ID      = '37858'
        IMAGE_NAME      = 'omargali-ruslan-devops'
        CONTAINER_NAME  = 'omargali-ruslan-container'
    }

    stages {
        stage('Checkout') {
            steps {
                // Download the source code from GitHub
                checkout scm
                sh 'echo "Commit used by Jenkins:" && git log -1 --oneline'
            }
        }

        stage('Build') {
            steps {
                echo "Student: ${STUDENT_NAME} ${STUDENT_SURNAME}"
                echo "Group: ${STUDENT_GROUP}"
                echo "Student ID: ${STUDENT_ID}"
                sh '''
                    chmod +x scripts/*.sh
                    {
                      echo "Project:    ${IMAGE_NAME}"
                      echo "Student:    ${STUDENT_NAME} ${STUDENT_SURNAME}"
                      echo "Build:      #${BUILD_NUMBER}"
                      echo "Commit:     $(git rev-parse --short HEAD)"
                      echo "Built at:   $(date '+%Y-%m-%d %H:%M:%S')"
                    } > build-info.txt
                    cat build-info.txt
                    ls -la
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    set -e
                    echo "Checking required project files..."
                    for f in Dockerfile docker-compose.yml .gitignore app/app.py \
                             config/app.conf Omargali_Ruslan_info.txt scripts/Omargali_Ruslan_system.sh; do
                      [ -f "$f" ] || { echo "MISSING: $f"; exit 1; }
                      echo "OK  $f"
                    done
                    bash -n scripts/Omargali_Ruslan_system.sh && echo "OK  Bash script syntax"
                    grep -q "Student ID: ${STUDENT_ID}" Omargali_Ruslan_info.txt && echo "OK  Student ID in info file"
                    ./scripts/Omargali_Ruslan_system.sh
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} -t ${IMAGE_NAME}:latest .
                    docker images ${IMAGE_NAME}
                '''
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    # Remove the old container if it exists, then start a new one
                    docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
                    docker run -d --name ${CONTAINER_NAME} \
                        -e STUDENT_NAME="${STUDENT_NAME}" \
                        -e STUDENT_SURNAME="${STUDENT_SURNAME}" \
                        -e STUDENT_GROUP="${STUDENT_GROUP}" \
                        -e STUDENT_ID="${STUDENT_ID}" \
                        ${IMAGE_NAME}:latest
                    sleep 3
                    docker ps --filter name=${CONTAINER_NAME}
                    echo "----- Container logs -----"
                    docker logs ${CONTAINER_NAME}
                    echo "----- Request inside the container -----"
                    docker exec ${CONTAINER_NAME} wget -qO- http://127.0.0.1:8000/health
                '''
            }
        }
    }

    post {
        success {
            archiveArtifacts artifacts: 'build-info.txt', fingerprint: true
            echo "Pipeline finished successfully for ${STUDENT_NAME} ${STUDENT_SURNAME}"
        }
        failure {
            echo 'Pipeline failed. Open the red stage and read its Console Output.'
        }
    }
}
