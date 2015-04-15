#!/usr/bin/env bash

trap 'exit 1' ERR   # Exit script with error if command fails

cd $(dirname "${BASH_SOURCE[0]}")

if [[ -z $(which docker) ]]; then
    echo "Missing docker, which is required for building, testing and pushing."
    exit 2
fi

declare IMAGE_NAME="bachelorthesis/development-environment"
declare BASE_IMAGES_DIRECTORY="./base-image"


function build_base_image() {
    base_image="${1}"
    base_image_directory="${BASE_IMAGES_DIRECTORY}/${base_image}"

    if [ ! -d "$base_image_directory" ]; then
    	echo "Unable to find ${base_image}'s directory."
        exit 1
    fi

    while read tag; do
        docker build -t "${IMAGE_NAME}:${tag}" "${base_image_directory}"
    done < "${base_image_directory}/tags"
}


function test_base_image() {
    base_image="${1}"
    base_image_directory="${BASE_IMAGES_DIRECTORY}/${base_image}"

	docker history "${IMAGE_NAME}:${base_image}" 2> /dev/null

	if [ $? -eq 1]; then
		echo "Unable to test ${IMAGE_NAME}:${base_image}, the image does not exist."
        exit 1
    fi

    if [[ -z $(which bats) ]]; then
        echo "Missing bats, which is required for testing."
        exit 2
    fi

    bats "${base_image_directory}/test.bats"
}


function push_base_image() {
    base_image="${1}"
    base_image_directory="${BASE_IMAGES_DIRECTORY}/${base_image}"

    if [ ! -d "$base_image_directory" ]; then
    	echo "Unable to find ${IMAGE_NAME}:${base_image}'s directory."
    	exit 1
    fi

    [ -z "${DOCKER_EMAIL}" ]    && { echo "Need to set DOCKER_EMAIL";    exit 1; }
    [ -z "${DOCKER_USER}" ]     && { echo "Need to set DOCKER_USER";     exit 1; }
    [ -z "${DOCKER_PASSWORD}" ] && { echo "Need to set DOCKER_PASSWORD"; exit 1; }

    if [[ $EUID -ne 0 ]]; then
        sudo docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
    else
        docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASSWORD
    fi

    while read tag; do
        docker history "${IMAGE_NAME}:${tag}" 2> /dev/null

        if [ $? -eq 1 ]; then
            echo "Cant push ${IMAGE_NAME}:${tag}, the image does not exist."
            exit 1
        fi
        
        if [[ $EUID -ne 0 ]]; then
            sudo docker push "${IMAGE_NAME}:${tag}"
        else
            docker push "${IMAGE_NAME}:${tag}"
        fi

    done < "${base_image_directory}/tags"
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
    for version in ${BASE_IMAGES_DIRECTORY}/*; do
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
               build_base_image $version
            done
            ;;
         
        test)
            for version in "${versions[@]}"; do
               test_base_image $version
            done
            ;;

        push)
            for version in "${versions[@]}"; do
               push_base_image $version
            done
            ;;
    esac
done
