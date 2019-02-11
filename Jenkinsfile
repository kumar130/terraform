pipeline {
agent {label 'master'}

stages {
  stage('CHECKOUT') {
    steps {
    checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [],
    submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/kumar130/spring-petclinic.git']]])
    }
  }

  stage('BUILD') {
    steps {
    sh 'ls'
    sh 'pwd'
    sh 'chmod 777 mvnw'
    sh './mvnw package'
  }
}

stage('Docker Build') {
  steps {
    sh '''
    sudo docker build -t saurav812/image .
    '''
  }
}

  stage('Docker Push') {
    steps {
      sh "sudo docker login -u saurav812 -p Gold@123"
     sh 'sudo docker push saurav812/image:latest'
    }
  }

  stage('Deploy') {
      steps {
    node ('slave'){

      sh 'docker pull saurav812/image:latest'
      sh 'docker run -p 8888:8080'
    }
    }
  }

}//Eng of stages
} //End of Pipeline
