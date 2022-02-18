 #!/bin/bash

# set SSH_KEY_REPO in the environment before running
HEAD_HASH=$(git ls-remote ${SSH_KEY_REPO} HEAD | awk '{FS=" "} {print $1}')

# clone the keys into a /tmp directory
TMP_DIR=/tmp/$HEAD_HASH
if [[ -e $TMP_DIR ]]; then
    rm -rf $TMP_DIR
fi
git clone $KEY_REPO $TMP_DIR

# create a new authorized_keys file from scratch
touch $TMP_DIR/authorized_keys
echo "### THIS FILE IS AUTOMATICALLY UPDATED! Do not change manually, your changes will be overwritten. ###" >> $TMP_DIR/authorized_keys
echo "### Add your public keys to this repo instead: ${SSH_KEY_REPO} ###" >> $TMP_DIR/authorized_keys
echo "" >> $TMP_DIR/authorized_keys

for f in $(find ${TMP_DIR} -type f -name "*.pub"); do
    echo "# $(basename $f)" >> $TMP_DIR/authorized_keys
    cat $f >> $TMP_DIR/authorized_keys
    echo "" >> $TMP_DIR/authorized_keys
done

# copy over the new authorized_keys file
cp $TMP_DIR/authorized_keys $HOME/.ssh/authorized_keys
chmod 644 $HOME/.ssh/authorized_keys
