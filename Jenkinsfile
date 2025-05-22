pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  volumes:
    - name: docker-socket
      emptyDir: {}
    - name: workdir
      emptyDir: {}
  imagePullSecrets:
    - name: insilico-docker-registry
  containers:
    - name: docker-daemon
      image: docker:19.03.1-dind
      securityContext:
        privileged: true
      volumeMounts:
        - name: docker-socket
          mountPath: /var/run
    - name: buildmain
      image: dev-docker.seegene.com/services/jobmanager-build-base:latest
      readinessProbe:
        exec:
          command: [sh, -c, "ls -S /var/run/docker.sock"]
      command: ["sleep"]
      args: ["99d"]
      volumeMounts:
        - name: workdir
          mountPath: /work
        - name: docker-socket
          mountPath: /var/run
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
