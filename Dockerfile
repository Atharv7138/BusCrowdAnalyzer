# Stage 1: Build
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
# Download the runner explicitly and build
RUN mvn clean package -DskipTests && \
    mvn dependency:copy -Dartifact=com.heroku:webapp-runner:9.0.52.1 -DoutputDirectory=target/dependency

# Stage 2: Runtime (The fix is here)
FROM eclipse-temurin:17-jdk-focal
WORKDIR /app
COPY --from=build /app/target/*.war app.war
COPY --from=build /app/target/dependency/webapp-runner.jar webapp-runner.jar

CMD java $JAVA_OPTS -jar webapp-runner.jar --port $PORT app.war
