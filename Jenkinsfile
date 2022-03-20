pipeline { 

    environment { 

        registry = 'braunsteinshlomi/aspnetcore-realworld-example-app' 
        registryCredential = 'artifactory-credentials'         
        dockerImage = ''
        branch_Name = "shlomi"

    }

    agent any 

    stages { 
        
        stage('Cloning our Git') { 

            steps { 
                sh 'echo branch name is: $branch_Name'
                git([url: 'https://github.com/shlomibra/aspnetcore-realworld-example-app', branch: branch_Name])
            }

        } 

        stage('Building our image') { 

            steps { 

                script { 

                    dockerImage = docker.build(registry + ":$BUILD_NUMBER")

                }

            } 

        }

       stage('Push image') { 

            steps { 

                script { 

                    docker.withRegistry('157.175.64.207:8081', registryCredential) {
                    dockerImage.push()

                    }

                } 

            }

        } 

        stage('Pull image') { 

            steps { 
                
              script {
                
                    dockerImage.pull() 
                    
                    }

            }

        } 
        
        stage('Run and test server') { 

            steps { 
                 script { 
                        sh "docker run -d -p 5000:5000 $registry:$BUILD_NUMBER"
                        sh 'curl localhost:5000'                        
                        sh 'docker kill $(docker ps -a -q  --filter ancestor=$registry:$BUILD_NUMBER) || true'
                    }
            }

        } 

       stage('Remove Unused docker image') {
           
          steps{
                    sh "docker rmi $registry:$BUILD_NUMBER"
        }
           
       }

    }

}
