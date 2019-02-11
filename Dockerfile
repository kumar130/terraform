FROM java:openjdk-8-jdk-alpine

ADD target/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar .

RUN java -jar spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar
