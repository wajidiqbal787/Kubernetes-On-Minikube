# ---------- Stage 1: Build ----------
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and download dependencies first (cache layer)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and build jar
COPY src ./src
RUN mvn package -DskipTests

# ---------- Stage 2: Runtime ----------
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copy final JAR from previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

