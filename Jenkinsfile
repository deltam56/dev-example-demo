pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  volumes:
    - name: docker-socket
      hostPath:
        path: /var/run/docker.sock
    - name: workdir
      emptyDir: {}
  containers:
    - name: buildmain
      image: docker:24.0.7-cli
      command: ["sleep"]
      args: ["99d"]
      volumeMounts:
        - name: workdir
          mountPath: /work
        - name: docker-socket
          mountPath: /var/run/docker.sock
'''
            defaultContainer 'buildmain'
        }
    }

    stages {
        stage('Install dependencies') {
            steps {
                container('buildmain') {
                    sh './build-and-push-docker-regitry.sh'
                }
            }
        }

        stage('Build') {
            steps {
                container('buildmain') {
                    echo "#########It is build main##########"
                }
            }
        }

        stage('Unit test') {
            steps {
                container('buildmain') {
                    echo "#########It is Unit TEST##########"
                }
            }
        }

        stage('Deploy') {
            steps {
                container('buildmain') {
                    echo "#########It is Deploy! #############"
                }
            }
        }
    }

    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if the pipeline succeeds'
        }
        failure {
            echo 'This will run only if the pipeline fails'
        }
    }
}
