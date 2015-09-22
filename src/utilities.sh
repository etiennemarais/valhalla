#!/bin/bash

# Outputs to console in the colour yellow
outputInYellow() {
    echo -n -e "\033[0;33m"
    echo $*
    echo -n -e "\033[0m"
}