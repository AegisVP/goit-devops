#!/bin/bash

tfdestroy() {
  cd /Users/vpysarenko/Repos/GoIT/Masters/goit-devops/terraform
  terraform apply -destroy -auto-approve -target=module.argo-cd
  terraform apply -destroy -auto-approve -target=module.jenkins
  terraform apply -destroy -auto-approve -target=module.eks
}

SLEEP_TIME=0

# Check if an argument is provided
if [ -n "$1" ]; then
  if [[ "$1" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    SLEEP_TIME=$1
  else
    echo "Error: Argument must be a non-negative number."
    exit 1
  fi
fi

if [ $SLEEP_TIME -ne 0 ]; then
  echo "Sleeping for $SLEEP_TIME seconds before running terraform destroy..."
  (sleep $SLEEP_TIME ; tfdestroy) &
  echo "Terraform destroy command has been initiated in the background. Do not close this terminal window."
else
  tfdestroy
fi