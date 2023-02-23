//SCRIPTED

//DECLARATIVE
pipeline {
	agent any
	environment {
		dockerHome = tool 'MyDocker'
		PATH = "$dockerHome/bin:$PATH"
	}

	stages {
		stage('Checkout') {
			steps {
				sh 'docker version'
				echo "Build"
				echo "PATH - $PATH"
				echo "BUILD_NUMBER - $env.BUILD_NUMBER"
				echo "BUILD_ID - $env.BUILD_ID"
				echo "JOB_NAME - $env.JOB_NAME"
				echo "BUILD_TAG - $env.BUILD_TAG"
				echo "BUILD_URL - $env.BUILD_URL"
			}
		}
		// stage('Compile') {
		// 	steps {
		// 		sh "mvn clean compile"
		// 	}
		// }

		
		// stage('Integration Test') {
		// 	steps {
		// 		sh "mvn failsafe:integration-test failsafe:verify"
		// 	}
		// }

		// stage('Package') {
		// 	steps {
		// 		sh "mvn package -DskipTests"
		// 	}
		// }

		// stage('Build Docker Image') {
		// 	steps {
		// 		script {
		// 			dockerImage = docker.build("in28min/currency-exchange-devops:${env.BUILD_TAG}")
		// 		}

		// 	}
		// }

		// stage('Push Docker Image') {
		// 	steps {
		// 		script {
		// 			docker.withRegistry('', 'dockerhub') {
		// 				dockerImage.push();
		// 				dockerImage.push('latest');
		// 			}
		// 		}
		// 	}
		// }
	} 
	
	post {
		always {
			echo 'Im awesome. I run always'
		}
		success {
			echo 'I run when you are successful'
		}
		failure {
			echo 'I run when you fail'
		}
	}
}
