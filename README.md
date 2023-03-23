# BP-ECR-REPO-CREATE-STEP

This step checks if the ECR repository specified in the configuration already exists. If it does not exist, the script will create a new repository with the specified name, ensuring that the repository is available for pushing images.

## Setup
* Clone the code available at [BP-ECR-REPO-CREATE-STEP](https://github.com/OT-BUILDPIPER-MARKETPLACE/BP-ECR-REPO-CREATE-STEP.git)
* Build the docker image
```
git submodule init
git submodule update
docker build -t ot/ecr:0.1 .