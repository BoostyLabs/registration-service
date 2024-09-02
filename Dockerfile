FROM eclipse-temurin:21.0.4_7-jdk-noble AS build
ARG HOME=/usr/app
ADD . $HOME
WORKDIR $HOME
RUN --mount=type=cache,target=/root/.m2 ./mvnw clean package -DskipTests

FROM eclipse-temurin:21.0.4_7-jre-alpine AS app
ARG HOME=/usr/app
ARG ENV=local
ARG GRPC_PORT=50051
COPY --from=build /usr/app/target/registration-service*.jar $HOME/service.jar
COPY ./entrypoint.sh $HOME/entrypoint.sh
RUN chmod +x $HOME/entrypoint.sh
EXPOSE ${GRPC_PORT}
WORKDIR $HOME
CMD ["./entrypoint.sh"]
