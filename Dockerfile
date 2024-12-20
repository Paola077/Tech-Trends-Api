FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml ./
COPY mvnw ./
COPY .mvn .mvn/

RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jdk-jammy

WORKDIR /app

COPY --from=build /app/target/Tech-Trends-0.0.1-SNAPSHOT.jar app.jar

ENV SPRING_PROFILE_ACTIVE=prod

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]

