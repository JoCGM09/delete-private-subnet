#!/bin/bash
#if [ -f ../.env ]; then
#  source ../.env
#fi

# login validation
ibmcloud login --apikey $IBM_CLOUD_API_KEY -r 'us-south' -g 'Unique'

# Power Workspace target
service_list_output=$(ibmcloud pi ws ls)
service_crn=$(echo "$service_list_output" | awk -v workspace="$IBM_POWER_WORKSPACE_NAME" '$0 ~ workspace {print $1}')
ibmcloud pi ws target "$service_crn"

#########################  Script 3: Delete private subnet  ##########################   

subnet_id=""

subnets_output=$(ibmcloud pi subnet list)
subnet_id=$(echo "$subnets_output" | awk -v subnet="$IBM_POWER_SUBNET_NAME" '$2 == subnet {print $1}')

if [ -n "$subnet_id" ]; then
  if ibmcloud pi subnet delete "$subnet_id"; then
    echo "Subnet deleted successfully."
  else
    echo "Error: Unable to delete subnet."
    exit 1
  fi
else
  echo "Subnet does not exist."
  exit 1
fi