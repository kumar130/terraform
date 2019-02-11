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
      sh "sudo docker login -u XXX -p XXX"
     sh 'sudo docker push XXX/image:latest'
    }
  }

  stage('Deploy') {
      steps {
    node ('slave'){
      sh "sudo docker login -u XXX -p XXX"
      sh 'docker pull saurav812/image:latest'
      sh 'sudo docker run -p 8666:8888 XXX/image'
    }
    }
  }

}//Eng of stages
} //End of Pipeline
