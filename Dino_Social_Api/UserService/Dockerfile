# Stage 1: Build the application
FROM maven:3.9.9-eclipse-temurin-21-alpine AS build
WORKDIR /app

# 1. Tối ưu Cache: Tải dependencies trước cho toàn bộ multi-module project
COPY pom.xml .
COPY Common/pom.xml Common/
COPY UserService/pom.xml UserService/
COPY NotificationService/pom.xml NotificationService/
COPY RabbitMQService/pom.xml RabbitMQService/
RUN mvn dependency:go-offline -pl UserService -am -B

# 2. Copy source code và build module cụ thể
COPY Common/src Common/src
COPY UserService/src UserService/src
RUN mvn clean package -pl UserService -am -DskipTests

# Stage 2: Create the final runtime image
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Tạo user không có quyền root để tăng tính bảo mật
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copy file jar từ stage build
# Lưu ý: Đường dẫn source từ stage build là /app/UserService/target/*.jar
COPY --from=build /app/UserService/target/*.jar app.jar

# Cấu hình tối ưu cho Java trong Container
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -Dfile.encoding=UTF-8"

EXPOSE 8080

# Chạy ứng dụng với các tham số tối ưu
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]