#!/bin/bash

# Check if an argument is provided
  SLEEP_TIME=0
if [ -n "$1" ]; then
  if [[ "$1" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    SLEEP_TIME=$1
  else
    echo "Error: Argument must be a non-negative number."
    exit 1
  fi
fi

echo "Sleeping for $SLEEP_TIME seconds before running terraform destroy..."
(sleep $SLEEP_TIME ; cd /Users/vpysarenko/Repos/GoIT/Masters/goit-devops/terraform && terraform apply -destroy -auto-approve) &

if [ $SLEEP_TIME -ne 0 ]; then
  echo "Terraform destroy command has been initiated in the background. Do not close this terminal window."
fi