# deploy.sh
#! /bin/bash

SHA1=$1

# Create new Elastic Beanstalk version
EB_BUCKET=hello-bucket
DOCKERRUN_FILE=$SHA1-Dockerrun.aws.json
AWS_REGION=eu-central-1

sed "s/<TAG>/$SHA1/" < Dockerrun.aws.template.json > $DOCKERRUN_FILE
aws s3 cp $DOCKERRUN_FILE s3://$EB_BUCKET/$DOCKERRUN_FILE --region $AWS_REGION
aws elasticbeanstalk create-application-version --application-name hello \
  --version-label $SHA1 --source-bundle S3Bucket=$EB_BUCKET,S3Key=$DOCKERRUN_FILE \
  --region $AWS_REGION

# Update Elastic Beanstalk environment to new version
aws elasticbeanstalk update-environment --environment-name hello-env \
    --version-label $SHA1 \
    --region $AWS_REGION