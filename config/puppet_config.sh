#!/bin/bash

#################################
# Global settings
SHARED_PUPPET_DIR=
#################################

#############
# Functions #
#############
function configurePuppet()
{
  echo "-----"
  echo "Configuring puppet"

  if [ -d ${SHARED_PUPPET_DIR} ] ; then
    echo " > link 'hiera.yaml' from shared folder"
    ln -sf ${SHARED_PUPPET_DIR}/hiera.yaml /etc/puppetlabs/code/hiera.yaml

    echo " > remove 'modules' folder from guest /etc/puppetlabs"
    rm -rf /etc/puppetlabs/code/modules

    echo " > link 'modules' folder from shared folder"
    ln -sf ${SHARED_PUPPET_DIR}/environments/development/modules /etc/puppetlabs/code/modules
  else
    echo "Error! Cannot find ${SHARED_FOLDER_DIR}"
  fi;
}

########
# Main #
########

# use argument for config folder path
if [ -n $1 ] ; then
  SHARED_PUPPET_DIR=$1
fi;

configurePuppet

echo "-----"
