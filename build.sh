#!/usr/bin/env bash

trap 'exit 1' ERR   # Exit script with error if command fails

cd $(dirname "${BASH_SOURCE[0]}")

if [[ -z $(which docker) ]]; then
    echo "Missing docker, which is required for building, testing and pushing."
    exit 3
fi

declare IMAGE_NAME="bachelorthesis/development-environment"
declare MACHINE_DIRECTORY="./machine"


function build() {
    image="${1}"
    directory="${MACHINE_DIRECTORY}/${image}"

    if [ ! -d "$directory" ]; then
        echo "Cant build image ${IMAGE_NAME}:${image}, the image does not exist"
        exit 1
    fi

    docker build -t "${IMAGE_NAME}:${image}" "${directory}"
}


function test() {
    image="${1}"
    directory="${MACHINE_DIRECTORY}/${image}"

    if [ ! -d "$directory" ]; then
        echo "Cant build image ${IMAGE_NAME}:${image}, the image does not exist"
        exit 1
    fi

	docker history "${IMAGE_NAME}:${image}" 2> /dev/null

    if [ $? -eq 1 ]; then
        echo "Cant test ${IMAGE_NAME}:${image}, the image is not built"
        exit 2
    fi

    #bats "${base_image_directory}/test.bats"
}


function push() {
    image="${1}"
    directory="${MACHINE_DIRECTORY}/${image}"

    if [ ! -d "$directory" ]; then
        echo "Cant build image ${IMAGE_NAME}:${image}, the image does not exist"
        exit 1
    fi

    docker history "${IMAGE_NAME}:${image}" 2> /dev/null

    if [ $? -eq 1 ]; then
        echo "Cant test ${IMAGE_NAME}:${image}, the image is not built"
        exit 2
    fi

    [ -z "${DOCKER_EMAIL}" ]    && { echo "Need to set DOCKER_EMAIL";    exit 1; }
    [ -z "${DOCKER_USER}" ]     && { echo "Need to set DOCKER_USER";     exit 1; }
    [ -z "${DOCKER_PASSWORD}" ] && { echo "Need to set DOCKER_PASSWORD"; exit 1; }

    if [[ $EUID -ne 0 ]]; then
        sudo docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
        sudo docker push "${IMAGE_NAME}:${image}"
    else
        docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
        sudo docker push "${IMAGE_NAME}:${image}"
    fi
}


#
# Handle input
#
versions=()
actions=("$@")

while getopts ":v:" opt; do
  case $opt in
    v)
      versions+=("$OPTARG")
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

if [ ${#versions[@]} -eq 0 ]; then
    for version in ${MACHINE_DIRECTORY}/*; do
        versions+=($(basename $(echo $version)))
    done
fi

if [ ${#actions[@]} -eq 0 ]; then
    actions=(build test push)
fi

for action in "${actions[@]}"; do 
    case "$action" in
        build)
            for version in "${versions[@]}"; do
               build $version
            done
            ;;
         
        test)
            for version in "${versions[@]}"; do
               test $version
            done
            ;;

        push)
            for version in "${versions[@]}"; do
               push $version
            done
            ;;
    esac
done
