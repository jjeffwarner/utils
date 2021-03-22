# Settng up stuff on GCP

First off, gotta give credit where credit is due. Heavily inspired by https://itnext.io/how-ive-slashed-the-cost-of-my-dev-environments-by-90-9c1082ad1baf

I started a new job and got an M1 Mac and some stuff we use doesn't work on it. So I wanted to have a dedicated GCP server to work against. So I set this up.

# Initial Setup
These just have to happen once.

## Setup a static IP

Using us-central1 seems reasonable so create the static IP address.

```
gcloud compute addresses create jw-boulder-dev-vm-ip \ 
--project=database-schema-research \ 
--network-tier=standard \
--region=us-central1
````

## Firewall Rules


## The VM


## Thoughts
CloudSQL or Docker for Redis and Postgres?

