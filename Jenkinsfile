pipeline {
  agent {
    docker {
      image 'hashicorp/terraform:latest'
      args '-u root:root'
    }
  }

  environment {
    AWS_DEFAULT_REGION = 'ap-south-1'
  }

  parameters {
    booleanParam(name: 'DESTROY', defaultValue: false, description: 'Run terraform destroy instead of apply')
  }

  options {
    ansiColor('xterm')
    timestamps()
  }

  stages {
    stage('Checkout') {
      steps {
        // If your Jenkins job is not configured with SCM, use explicit Git checkout:
        git branch: 'main', url: 'https://github.com/your-org/your-repo.git', credentialsId: 'github-creds'

        // If the job is configured with SCM, you can keep checkout scm instead:
        // checkout scm
      }
    }

    stage('Terraform Format') {
      steps {
        dir('Infra') {
          sh 'terraform fmt -check -recursive'
        }
      }
    }

    stage('Terraform Init') {
      steps {
        dir('Infra') {
          sh 'terraform init -input=false'
        }
      }
    }

    stage('Terraform Validate') {
      steps {
        dir('Infra') {
          sh 'terraform validate'
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          dir('Infra') {
            sh 'terraform plan -input=false -out=tfplan'
          }
        }
      }
    }

    stage('Terraform Apply or Destroy') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
          dir('Infra') {
            script {
              if (params.DESTROY) {
                sh 'terraform destroy -auto-approve'
              } else {
                sh 'terraform apply -input=false tfplan'
              }
            }
          }
        }
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: 'Infra/tfplan', allowEmptyArchive: true
    }
    cleanup {
      cleanWs()
    }
  }
}
