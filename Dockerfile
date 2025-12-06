FROM eclipse-temurin:17-jre-alpine
COPY . /app
WORKDIR /app
ENTRYPOINT ["java", "-jar", "*.jar"]
