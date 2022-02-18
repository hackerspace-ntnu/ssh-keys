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

# create a new authorized_keys file from scratch
touch $TMP_DIR/authorized_keys
echo "### THIS FILE IS AUTOMATICALLY UPDATED! Do not change manually, your changes will be overwritten. ###" >> $TMP_DIR/authorized_keys
echo "### Add your public keys to this repo instead: ${SSH_KEY_REPO} ###" >> $TMP_DIR/authorized_keys
echo "" >> $TMP_DIR/authorized_keys

# allow for specifying a local authorized_keys file in the environment that should be included alongside the keys in the repository
# can be used to ensure that script errors do not cause you to lose SSH access
if [[ -e $LOCAL_SSH_KEYS ]]; then
    echo "### Local keyfile start ###" >> $TMP_DIR/authorized_keys
    cat $LOCAL_SSH_KEYS >> $TMP_DIR/authorized_keys
    echo "### Local keyfile end ###" >> $TMP_DIR/authorized_keys
    echo "" >> $TMP_DIR/authorized_keys
fi

for f in $(find ${TMP_DIR} -type f -name "*.pub"); do
    echo "# $(basename $f)" >> $TMP_DIR/authorized_keys
    cat $f >> $TMP_DIR/authorized_keys
    echo "" >> $TMP_DIR/authorized_keys
done

# copy over the new authorized_keys file
cp $TMP_DIR/authorized_keys $HOME/.ssh/authorized_keys
chmod 644 $HOME/.ssh/authorized_keys
