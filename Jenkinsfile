pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t test-image .'
      }
    }
    stage('Run') {
      steps {
        sh 'docker run --rm test-image'
      }
    }
    stage('Deploy') {
      steps {
        sh '''
          docker stop app || true
          docker rm app || true
          docker run -d --name app -p 80:80 test-image
        '''
      }
    }
  }
}

