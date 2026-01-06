pipeline {
  agent any
  options {
    skipDefaultCheckout(true)
  // i had to add this or it breaks for some reason now it breaks cuz its here :sob:
  }
  environment {
    IMG_NAME = "2312702123127302/dummy-app"
    IMG_TAG = "latest"
  }
  stages {
    stage('Build') {
      steps {
        deleteDir()
        checkout scm
        sh 'docker build -t $IMG_NAME:$IMG_TAG .'
      }
    }
    stage('Push') {
      steps {
        withCredentials([
          usernamePassword(
            credentialsId: 'dockerhub-creds',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS'
          )
        ]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
        }
        sh 'docker push $IMG_NAME:$IMG_TAG'
      }
    }
    stage('Deploy') {
      steps {
        sh '''
          docker stop app || true
          docker rm app || true
          docker run -d --name app -p 80:80 $IMG_NAME:$IMG_TAG
        '''
        // this is what i get for sleeping at 4am bruv
      }
    }
  }
}

