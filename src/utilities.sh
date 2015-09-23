#!/bin/bash

# this is necessary so that something like
# ./commandA | ./printNiceOutput
# is returning with exitcode != 0 if any of the commands in the
# pipeline failed
set -o pipefail

# Outputs to console in the colour yellow
outputInYellow() {
    echo -n -e "\033[0;33m"
    echo $*
    echo -n -e "\033[0m"
}

# Outputs to console in the colour red
outputInRed() {
    echo -n -e "\033[0;31m"
    echo $*
    echo -n -e "\033[0m"
}

# Outputs to console in the colour green
outputInGreen() {
    echo -n -e "\033[0;32m"
    echo $*
    echo -n -e "\033[0m"
}

# will only check if the specified volume mountpoint from the outside is ok or might not work
checkForVolumeMountpoint() {
    if [ "$(uname -s)" = "Darwin" ] ; then
        # on Mac only /Users is shared within the Boot2Docker VM
        # see: https://docs.docker.com/installation/mac/#mount-a-volume-on-the-container
        if ! echo "$1" | grep -q '^/Users/' ; then
            error "On MacOS you need to use only volumes which are located somewhere inside /Users but '$1' won't work.."
        fi
    fi
    outputInGreen "Done"
}

error() {
    echo -n -e "\033[0;31m"
    echo -e "$@"
    echo -n -e "\033[0m"
    exit 2
}