#!/bin/sh

sshagent (['22a85fad-8bf3-478b-8daf-468fbf902abe']) {
		                     
wget http://65.1.231.149:8081/repository/spring-boot1/org/springframework/gs-spring-boot/1.0.1/gs-spring-boot-1.0.1.jar
		     
nohup java -jar gs-spring-boot-1.0.1.jar  --server.port=8083
