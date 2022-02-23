#!/bin/bash

if [[ -z $SSH_KEY_REPO ]]; then
    echo "no SSH key repository URL was specified"
    echo "set SSH_KEY_REPO in your environment, then try again"
    exit 1
fi

# set SSH_KEY_REPO in the environment before running
HEAD_HASH=$(git ls-remote ${SSH_KEY_REPO} HEAD | awk '{FS=" "} {print $1}')
if [[ -z $HEAD_HASH ]]; then
    echo "failed to read key repository"
    echo "check that you have access to the key repository and try again"
    exit 1
fi

# clone the keys into a /tmp directory
TMP_DIR=/tmp/$HEAD_HASH
if [[ -e $TMP_DIR ]]; then
    rm -r $TMP_DIR
fi
mkdir $TMP_DIR
git clone $SSH_KEY_REPO $TMP_DIR

if [[ $? -ne 0 ]]; then
    echo "failed to clone key repository"
    echo "check that you have access to the key repository and try again"
    exit 1
fi

./update_ssh_keys.sh
rm -r $TMP_DIR
