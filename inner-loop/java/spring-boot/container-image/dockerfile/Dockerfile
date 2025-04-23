FROM eclipse-temurin:24-jre AS builder
WORKDIR /workspace
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar
RUN java -Djarmode=tools -jar app.jar extract --layers --destination app

FROM eclipse-temurin:24-jre
RUN useradd spring
USER spring
WORKDIR /workspace
COPY --from=builder workspace/app/dependencies/ ./
COPY --from=builder workspace/app/spring-boot-loader/ ./
COPY --from=builder workspace/app/snapshot-dependencies/ ./
COPY --from=builder workspace/app/application/ ./
ENTRYPOINT ["java", "-jar", "app.jar"]