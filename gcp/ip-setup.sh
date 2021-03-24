#! /bin/bash
# Setup the static IP and firewall rules

gcloud compute addresses create jw-boulder-dev-vm-ip \
--project=database-schema-research \
--network-tier=standard \
--region=us-central1

IP_ADDRESS_DEV_MACHINE=$(gcloud compute addresses list \
--filter="name:jw-boulder-dev-vm-ip AND region:us-central1" \
--format="value(address_range())"
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

gcloud compute firewall-rules create allow-ror-admin \
--project=database-schema-research \
--direction=INGRESS \
--network=default \
--action=ALLOW \
--rules=tcp:3000 \
--source-ranges=0.0.0.0/0 \
--target-tags=ruby-admin


# setup IAP access
gcloud compute firewall-rules create allow-rdp-ingress-from-iap \
  --direction=INGRESS \
  --action=allow \
  --rules=tcp:3389 \
  --source-ranges=35.235.240.0/20

gcloud compute firewall-rules create allow-ssh-ingress-from-iap \
  --direction=INGRESS \
  --action=allow \
  --rules=tcp:22 \
  --source-ranges=35.235.240.0/20

