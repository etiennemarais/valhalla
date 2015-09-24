#!/bin/bash

selfUpdateUsingGit() {
    outputInYellow "[Checking for updates]"
    GIT="git --git-dir=${BASE_DIR}/.git"
    COMMAND="$GIT fetch origin master"

    eval $COMMAND &>/dev/null

    if ! $GIT diff --quiet master..origin/master ; then
        upstream_commit=$($GIT log --pretty-oneline -1 origin/master | awk '{print $1}')

        if ! $GIT branch --contains $upstream_commit | grep -q '^* master$' ; then
            outputInRed "Your enviroment is not up to date, Getting the fresh changes..."

            $GIT reset --hard
            $GIT pull origin/master
        fi
    fi

    outputInGreen "Done"
}
