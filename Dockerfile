FROM java:8

WORKDIR /

ADD target/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar

EXPOSE 8888

CMD nohup java -jar spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar &
