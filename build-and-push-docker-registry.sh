#!/bin/sh

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT
cleanup() {
    trap - SIGINT SIGTERM ERR EXIT
    exit
}
DOCKER_REG="localhost:32050"
DOCKER_PATH="thhan"
DOCKER_REG_USER="supergate"
DOCKER_REG_PASSWORD="qwer1234"
DOCKER_IMG_NAME="supergate-dev-base"
DOCKER_IMG_TAG="latest"

echo ""
echo "Docker image build and push registry ..."
echo ""
echo date

export DOCKER_IMG_TAG=$DOCKER_IMG_TAG



docker-compose build supergate-dev-base

docker tag ${DOCKER_PATH}/${DOCKER_IMG_NAME}:${DOCKER_IMG_TAG} ${DOCKER_REG}/${DOCKER_PATH}/${DOCKER_IMG_NAME}:${DOCKER_IMG_TAG}
docker login -u ${DOCKER_REG_USER} -p ${DOCKER_REG_PASSWORD} ${DOCKER_REG}
docker push ${DOCKER_REG}/${DOCKER_PATH}/${DOCKER_IMG_NAME}:${DOCKER_IMG_TAG}
docker logout ${DOCKER_REG}

