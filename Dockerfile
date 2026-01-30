FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
COPY --from=build /target/*.war app.war
COPY --from=build /target/dependency/webapp-runner.jar webapp-runner.jar

# Render assigns a dynamic port via the $PORT variable
CMD java $JAVA_OPTS -jar webapp-runner.jar --port $PORT app.war