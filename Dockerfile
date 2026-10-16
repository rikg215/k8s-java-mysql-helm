# --- Build stage: compile the Spring Boot jar (no local Gradle/JDK needed) ---
FROM gradle:8.14-jdk17 AS build
WORKDIR /src
COPY settings.gradle build.gradle ./
COPY src ./src
RUN gradle bootJar --no-daemon

# --- Runtime stage: JRE only ---
FROM eclipse-temurin:17-jre
WORKDIR /opt/app
COPY --from=build /src/build/libs/bootcamp-kubernetes-exercise-project-1.0-SNAPSHOT.jar app.jar
USER 1001
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
