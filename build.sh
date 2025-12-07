#!/bin/bash

source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
source /opt/buildpiper/shell-functions/str-functions.sh
source /opt/buildpiper/shell-functions/file-functions.sh
source /opt/buildpiper/shell-functions/aws-functions.sh


logInfoMessage "I'll create an ECR repository if it doesn't exist."

SLEEP_DURATION="0s"
sleep $SLEEP_DURATION

if [ "$ASSUME_OTHER_ROLE" == true ]
then
	role_output=$(aws sts assume-role --role-arn arn:aws:iam::$ACCOUNT_ID:role/$ROLE_NAME --role-session-name $ROLE_SESSION_NAME)

	if [ $? -ne 0 ]; then
	  echo "Failed to assume role."
	  exit 1
	fi

	AWS_ACCESS_KEY_ID=$(echo $role_output | jq -r '.Credentials.AccessKeyId')
	AWS_SECRET_ACCESS_KEY=$(echo $role_output | jq -r '.Credentials.SecretAccessKey')
	AWS_SESSION_TOKEN=$(echo $role_output | jq -r '.Credentials.SessionToken')

	# Export the variables
	export AWS_ACCESS_KEY_ID
	export AWS_SECRET_ACCESS_KEY
	export AWS_SESSION_TOKEN
fi

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
TASK_STATUS=$?
saveTaskStatus ${TASK_STATUS} ${ACTIVITY_SUB_TASK_CODE}

