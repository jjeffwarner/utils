# Settng up stuff on GCP

First off, gotta give credit where credit is due. Heavily inspired by https://itnext.io/how-ive-slashed-the-cost-of-my-dev-environments-by-90-9c1082ad1baf

I started a new job and got an M1 Mac and some stuff we use doesn't work on it. So I wanted to have a dedicated GCP server to work against. So I set this up.

# Initial Setup
These just have to happen once. From the GCP console run the following scripts:

1. `cd gcp`
2. `./ip-setup.sh`
3. `./create-vm.sh`

Now you can log into the machine via the Compute Engine/VM Instances dashboard.

From inside the VM, you need to do the following:

1. Configure remote Github access via ssh
2. Log into Github and clone the util directory
3. run `./gcp/initial-setup.sh`
4. Clone repo to the machine 
5. Finish setup

## Setup a static IP

Use script ip-setup.sh

Using us-central1 seems reasonable so create the static IP address.

```
gcloud compute addresses create jw-boulder-dev-vm-ip \ 
--project=jjw-sg-working-area \ 
--network-tier=standard \
--region=us-central1
```

## Firewall Rules

Also setup during the ip-setup.sh script

## The VM

Use script create-vm.sh

## Using IAP for TCP forwarding
https://cloud.google.com/iap/docs/using-tcp-forwarding

## Disable External IP
Disable external IP and move to SSL -L approach.

## Github SSH configuration

Add the ssh key to github so you can access your repos.

# Running it

This was a bit fun to figure out. The binding switch lets in connections from any IP. That can be scary but the firewall on GCP should be configured to restrict where connections come in from.

```
rails s --port=3000 --binding=0.0.0.0
```
