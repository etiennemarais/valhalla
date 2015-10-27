#!/bin/bash
# Builds the docker images based on your config
# -t Is the tagname, Then is the actual filename and it gets prefixed with a pipe of the $image

buildDockerImage() {
    outputInYellow "[Building docker image: $*]"
    docker build --pull -t asgard/$image $BASE_DIR/images/$image | prefixWith "${FUNCNAME[0]}( $image )"
}

# Prefixes the output with the function name and the current image
prefixWith () {
    while read line
    do
        echo -n -e "\033[0;32m"
        printf "%50s: " "$1"
        echo -n -e "\033[0m"
        echo $line
    done
}
