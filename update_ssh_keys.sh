#!/bin/bash

# create a new authorized_keys file from scratch
touch authorized_keys.tmp
echo "### THIS FILE IS AUTOMATICALLY UPDATED! Do not change manually, your changes will be overwritten. ###" >> authorized_keys.tmp
echo "### Add your public keys to this repo instead: ${SSH_KEY_REPO} ###" >> authorized_keys.tmp
echo "" >> authorized_keys.tmp

# allow for specifying a local authorized_keys file in the environment that should be included alongside the keys in the repository
# can be used to ensure that script errors do not cause you to lose SSH access
if [[ -e $LOCAL_SSH_KEYS ]]; then
    echo "### Local keyfile start ###" >> authorized_keys.tmp
    cat $LOCAL_SSH_KEYS >> authorized_keys.tmp
    echo "### Local keyfile end ###" >> authorized_keys.tmp
    echo "" >> authorized_keys.tmp
fi

for f in $(find ${TMP_DIR} -type f -name "*.pub"); do
    echo "# $(basename $f)" >> authorized_keys.tmp
    cat $f >> authorized_keys.tmp
    echo "" >> authorized_keys.tmp
done

# copy over the new authorized_keys file
cp authorized_keys.tmp $HOME/.ssh/authorized_keys
chmod 644 $HOME/.ssh/authorized_keys
