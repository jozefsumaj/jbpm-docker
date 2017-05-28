#!/bin/sh

CONTAINER_NAME="jbpm"
IMAGE_NAME="jozefsumaj/jbpm-custom"
IMAGE_TAG="0.3"

if [ -f docker.pid ]; then
    echo "Container is already started"
    container_id=$(cat docker.pid)
    echo "Stoping container $container_id..."
    docker stop $container_id
    rm -f docker.pid
fi

image_jbpm_workbench=$(docker run -p 8080:8080 -p 8001:8001 -v /home/jozef/jbpm-git:/opt/jboss/wildfly/bin/.niogit -d --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG)
echo $image_jbpm_workbench > docker.pid
docker logs -f $image_jbpm_workbench

exit 0
