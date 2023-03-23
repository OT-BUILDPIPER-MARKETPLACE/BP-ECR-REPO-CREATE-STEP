# BP-ECR-REPO-CREATE-STEP

This step will help you create ECR Repositry if it is not there

## Setup
* Clone the code available at [BP-ECR-REPO-CREATE-STEP](https://github.com/OT-BUILDPIPER-MARKETPLACE/BP-ECR-REPO-CREATE-STEP.git)
* Build the docker image
```
git submodule init
git submodule update
docker build -t ot/ecr:0.1 .