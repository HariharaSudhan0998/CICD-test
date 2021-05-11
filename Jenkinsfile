pipeline {
   agent any

  stages {
     stage('Compile') {
     steps {
        sh(script: 'mvn compile')
        echo 'Compile...'
     }
   }
    stage('Unit Test') {
     steps {
        sh(script: 'mvn test')
	sh(script: 'mvn package')
	 junit 'target/surefire-reports/*.xml'

        echo 'Unit Test...'
     }
   } 
    stage('Code Quality') {
     steps {	    	    
           withSonarQubeEnv('sonarqube') {
		     sh """ 		        
                        mvn sonar:sonar \
                          -Dsonar.projectKey=sonarqube1 \
                          -Dsonar.host.url=http://65.2.108.33:9000 \
                          -Dsonar.login=eddc17c6929a3401c0f774a0d24563c7419106b7
                       """ 
		        } 
        
        echo 'Code Quality...'
	}
   }
    stage('Artifact Push') {
     steps {	          
	   //  sh(script: 'mvn  -version')
             sh(script: 'mvn   deploy')
	     
        echo 'Artifact Push...'
     }
   }
   stage('Deploy') {
	      steps{
		      
		   script {
               sshagent (credentials:['deployserver']) { 
                sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.9.220 "killall -9 java; rm -rf gs-spring-boot-1.0.1.jar; ls -ltr; ps -ef |grep java; "'
		       wget 'http://65.1.231.149:8081/repository/spring-boot1/org/springframework/gs-spring-boot/1.0.1/gs-spring-boot-1.0.1.jar'
            //    sh 'scp -o StrictHostKeyChecking=no target/*.jar ec2-user@172.31.9.220:/home/ec2-user/'
                sh 'ssh -o StrictHostKeyChecking=no ec2-user@172.31.9.220 "pwd; ls -ltr; java -jar gs-spring-boot-1.0.1.jar 2>> /dev/null >> /dev/null &"; sleep 10; ps -ef |grep java'
		   }                 
	      } 
        }
   }
    stage('Smoke Test') {
     steps {       			       
	     sh 'curl http://65.2.108.33:8080'
	   //  sh 'curl -u admin:devops123 -d "script=println InetAddress.localHost.hostAddress" http://65.2.108.33:8080'
	    
        echo 'Smoke Test...'
		     }
   }
    stage('Functional Test') {
     steps {	     
				    			
				  //    step([$class : 'Publisher', reportFilenamePattern : '**/testng-results.xml'])  
	           
			
        echo 'Functional Test...'
     }
   }
   stage('Email Notification') {
     steps {
	    // mail bcc: '', body: '''Hi all,
              //The pipeline run successfully.''', cc: '', from: '', replyTo: '', subject: 'Jenkins pipeline', to: 'hariharasudhan9894@gmail.com'
        echo 'Email Notification...'
     }
   }
  }
}
