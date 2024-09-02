#!/bin/sh

exec java \
-Dmicronaut.environments="$ENV" \
-Dgrpc.server.port="$GRPC_PORT" \
-jar service.jar
