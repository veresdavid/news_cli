#!/bin/bash

# TODO: hardcoded jar path
WIREMOCK_JAR_PATH=$HOME/wiremock/wiremock-standalone-3.9.2.jar

SCRIPT_FILE_PATH=$(readlink -f -- "$0")
WIREMOCK_ROOT_DIR=$(dirname -- "$SCRIPT_FILE_PATH")

java -jar $WIREMOCK_JAR_PATH --root-dir $WIREMOCK_ROOT_DIR
