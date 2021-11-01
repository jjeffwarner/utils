#!/bin/bash

# create the VM for boulder
# VM will have 1 CPU and 4GB of RAM. n1-standard-2 will have 2 CPU and 8GB RAM
#
# enable serial port logging with
# --metadata serial-port-logging-enable=true \

INSTANCE_NAME=jw-sg-dev-vm
PROJECT_ID=jjw-sg-working-area

gcloud compute instances create $INSTANCE_NAME \
--project=$PROJECT_ID \
--zone=us-central1-c \
--machine-type=n1-standard-8 \
--preemptible \
--image=ubuntu-1804-bionic-v20210412 \
--image-project=ubuntu-os-cloud \
--boot-disk-size=210GB \
--boot-disk-type=pd-standard \
--boot-disk-device-name=jw-sg-dev-vm \
--metadata-from-file startup-script=sg-dev-machine.sh \
--network-tier=STANDARD \
--address=$IP_ADDRESS_DEV_MACHINE \
--subnet=default \
--tags=http-server,https-server \
--labels=os=ubuntu-18-04-lts,cost-alloc=development,usage=sourcegraph,configuration=v1-1-3