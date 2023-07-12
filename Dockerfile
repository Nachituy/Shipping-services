#
# Build stage #
#
FROM maven:3.6.0-jdk-11-slim AS build 
WORKDIR /app

COPY src src
COPY pom.xml pom.xml
RUN mvn -f pom.xml clean package

#
# Package stage
#
FROM openjdk:8-jdk-alpine
ARG JAR_FILE
COPY --from=build /app/target/shipping-service-example-0.0.1-SNAPSHOT-spring-boot.jar /usr/local/lib/shipping.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/shipping.jar"]
