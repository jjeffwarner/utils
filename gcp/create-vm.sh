#!/bin/bash

# create the VM for boulder
# VM will have 1 CPU and 4GB of RAM. n1-standard-2 will have 2 CPU and 8GB RAM

gcloud compute instances create jw-boulder-dev-vm \
--project=database-schema-research \
--zone=us-central1-c \
--machine-type=n1-standard-1 \
--preemptible \
--image=ubuntu-1804-bionic-v20210315a \
--image-project=ubuntu-os-cloud \
--boot-disk-size=210GB \
--boot-disk-type=pd-standard \
--boot-disk-device-name=jw-boulder-dev-vm \
--metadata-from-file startup-script=boulder-dev-machine.sh \
--network-tier=STANDARD \
--address=$IP_ADDRESS_DEV_MACHINE \
--subnet=default \
--tags=http-server,https-server \
--labels=os=ubuntu-18-04-lts,cost-alloc=development,usage=boulder,configuration=v1-1-1