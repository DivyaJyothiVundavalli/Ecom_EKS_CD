pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'us-east-2'
    }
    stages{
        stage('Checkout SCM'){
            steps{
                    git branch: 'main',
                    url: "https://github.com/DivyaJyothiVundavalli/Ecom_EKS_CD.git"
            }
        }

        stage('test .tf files'){
            steps{
              //   echo "ls command:"
                sh 'ls -al'
            }
        }
        
         stage('Initializing Terraform'){
            steps{
                script{
                    dir('EKS'){
                         sh 'terraform init'
                    }
                }
            }
        }
        stage('Formating terraform code'){
            steps{
                script{
                    dir('EKS'){
                         sh 'terraform fmt'
                    }
                }
            }
        }
        stage('Validating Terraform'){
            steps{
                script{
                    dir('EKS'){
                         sh 'terraform validate'
                    }
                }
            }
        }
        stage('Previewing the infrastructure'){
            steps{
                script{
                    dir('EKS'){
                         sh 'terraform plan'
                    }
                    input(message: "Are you sure to proceed?", ok: "proceed")
                }
            }
        }
        stage('Creating/Destroying an EKS cluster'){
            steps{
                script{
                    dir('EKS'){
                         sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
        stage("Deploying Ecom"){
            steps{
                script{
                    dir('EKS/configuration-files'){
                        sh 'aws eks update-kubeconfig --name my-eks-cluster'
                        sh 'kubectl apply -f deployment.yml'
                        sh 'kubectl apply -f service.yml'
                    }
                }
            }
        }
    }
}
