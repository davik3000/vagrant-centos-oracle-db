#!/bin/bash
echo "-----"
echo "Create the nodes"

echo " > disabling plugins"
export VAGRANT_NO_PLUGINS=1

echo " > create and boot VM"
vagrant up oradb

#echo "-----"
#echo "Applying provision to nodes"
#vagrant provision

echo "-----"
echo "Reboot the nodes and apply guest addition through plugin"
unset VAGRANT_NO_PLUGINS
vagrant reload

echo "-----"
echo "Reboot the nodes"
vagrant reload