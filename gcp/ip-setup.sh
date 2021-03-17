#! /bin/bash
# Setup the static IP and firewall rules

gcloud compute addresses create jw-boulder-dev-vm-ip \
--project=database-schema-research \ 
--network-tier=standard \
--region=us-central1 

IP_ADDRESS_DEV_MACHINE=$(gcloud compute addresses list \
--filter=”name:name:test-boulder-dev-vm-ip AND region:region:us-central1" \
--format=”value(address_range())”
)

export IP_ADDRESS_DEV_MACHINE

#firewall rules
gcloud compute firewall-rules create allow-http \
--project=database-schema-research \
--direction=INGRESS \
--network=default \
--action=ALLOW \
--rules=tcp:80 \
--source-ranges=0.0.0.0/0 \
--target-tags=http-server

gcloud compute firewall-rules create allow-https \
--project=database-schema-research \
--direction=INGRESS \
--network=default \
--action=ALLOW \
--rules=tcp:443 \
--source-ranges=0.0.0.0/0 \
--target-tags=https-server
