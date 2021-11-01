#! /bin/bash
# Setup the static IP and firewall rules

PROJECT_ID=jjw-sg-working-area
ADDRESS_NAME=jw-sg-dev-vm-ip

gcloud compute addresses create $ADDRESS_NAME \
  --project=$PROJECT_ID \
  --network-tier=standard \
  --region=us-central1

IP_ADDRESS_DEV_MACHINE=$(gcloud compute addresses list \
--filter="name:$ADDRESS_NAME AND region:us-central1" \
--format="value(address_range())"
)

export IP_ADDRESS_DEV_MACHINE

#firewall rules
gcloud compute firewall-rules create allow-http \
  --project=$PROJECT_ID \
  --direction=INGRESS \
  --network=default \
  --action=ALLOW \
  --rules=tcp:80 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=http-server

gcloud compute firewall-rules create allow-https \
  --project=$PROJECT_ID \
  --direction=INGRESS \
  --network=default \
  --action=ALLOW \
  --rules=tcp:443 \
  --source-ranges=0.0.0.0/0 \
  --target-tags=https-server

# gcloud compute firewall-rules create allow-ror-admin \
#   --project=$PROJECT_ID \
#   --direction=INGRESS \
#   --network=default \
#   --action=ALLOW \
#   --rules=tcp:3000 \
#   --source-ranges=0.0.0.0/0 \
#   --target-tags=ruby-admin


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

# Setup IAP access for Rails console. Comment and/or remote 'allow-ror-admin' above
# gcloud compute firewall-rules create allow-rails-concole-ingress-from-iap \
#   --direction=INGRESS \
#   --action=allow \
#   --rules=tcp:3000 \
#   --source-ranges=35.235.240.0/20
