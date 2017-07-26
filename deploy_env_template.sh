#!/bin/bash

# calls ansible_playbook with a specified environment

# for use with ansible_agnostic_deployer

THIS_FILE=`basename $0`
GUID=${HOSTNAME:0:8}
ITERATION=362
CLOUDPROVIDER=
ENVTYPE=
SOFTWARE=
DELETE_APP=


# If called without --no-increment flag, 
# execute ansible-playbook and increment iteration

if [[ "$1" == "--no-increment" ]]; then
  ansible-playbook main.yml -e "env_type=$ENVTYPE cloud_provider=$CLOUDPROVIDER software_to_deploy=$SOFTWARE guid=$GUID$ITERATION ANSIBLE_REPO_PATH=`pwd` delete_app_post_deploy=$DELETE_APP" -vvvv  # --tags 
else
  ./$THIS_FILE --no-increment
  sed -i "s/ITERATION=$ITERATION/ITERATION=$(($ITERATION+1))/" $THIS_FILE
fi
