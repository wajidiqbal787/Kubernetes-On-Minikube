# Step 1: Base image
FROM amazoncorretto:17

# Step 2: App jar copy karo
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

# Step 3: Port expose
EXPOSE 8080

# Step 4: Run command
ENTRYPOINT ["java","-jar","/app.jar"]
