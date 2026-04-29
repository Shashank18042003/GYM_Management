# Stage 1: Build your Maven project
FROM maven:3.8.5-openjdk-17 AS build
COPY . /app
WORKDIR /app
# This runs the maven build to create your .war file
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat 10
FROM tomcat:10.1-jdk17-openjdk-slim
# Clean out default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy the .war file created in Stage 1 to the Tomcat folder
# We rename it to ROOT.war so it loads at the home page (/)
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
