#!/bin/bash
# Builds the docker images based on your config

buildDockerImage() {
    outputInYellow "[Building docker image: $*]"
    docker build -t asgard/$image $BASE_DIR/images/$image | prefix_with "${FUNCNAME[0]}( $image )"
}
