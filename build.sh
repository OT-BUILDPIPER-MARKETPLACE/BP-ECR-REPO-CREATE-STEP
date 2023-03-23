#!/bin/bash

source functions.sh
source log-functions.sh
source str-functions.sh
source file-functions.sh
source aws-functions.sh

logInfoMessage "I'll create an ECR repository if it doesn't exist."

SLEEP_DURATION="0s"
sleep $SLEEP_DURATION

# Check if AWS credentials are properly configured
if ! aws sts get-caller-identity >/dev/null 2>&1; then
  logErrorMessage "AWS CLI not properly configured. Please run 'aws configure' to set up your credentials."
  exit 1
fi

# Check if the repository already exists
if aws ecr describe-repositories --repository-names $ECR_REPO_NAME --region $AWS_REGION >/dev/null 2>&1; then
  logInfoMessage "ECR repository $ECR_REPO_NAME already exists"
else
  # Create the ECR repository
  aws ecr create-repository --repository-name $ECR_REPO_NAME --region $AWS_REGION
  logInfoMessage "ECR repository $ECR_REPO_NAME created successfully"
fi


