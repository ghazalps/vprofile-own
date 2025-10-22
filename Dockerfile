# ---------- Stage 1: Build the WAR ----------
FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# ---------- Stage 2: Run on Tomcat ----------
FROM tomcat:9-jdk21
LABEL maintainer="ghazalps ghazalpaslar@gmail.com"

# Remove the default Tomcat ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the WAR built from Maven
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]


