# Settng up stuff on GCP

First off, gotta give credit where credit is due. Heavily inspired by https://itnext.io/how-ive-slashed-the-cost-of-my-dev-environments-by-90-9c1082ad1baf

I started a new job and got an M1 Mac and some stuff we use doesn't work on it. So I wanted to have a dedicated GCP server to work against. So I set this up.

# Initial Setup
These just have to happen once. From the GCP console run the following scripts:

1. `./gcp/ip-setup.sh`
2. `./gcp/create-vm.sh`

Now you can log into the machine via the Compute Engine/VM Instances dashboard.

From inside the VM, you need to do the following:

1. Log into Github and clone the util directory
2. run `./gcp/initial-setup.sh`
3. Clone boulder repo to the machine 
4. Finish boulder setup

## Setup a static IP

Use script ip-setup.sh

Using us-central1 seems reasonable so create the static IP address.

```
gcloud compute addresses create jw-boulder-dev-vm-ip \ 
--project=database-schema-research \ 
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

# Setting Up Boulder et al.

## Ruby flags
For compilers to find ruby you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

# Running it

This was a bit fun to figure out. The binding switch lets in connections from any IP. That can be scary but the firewall on GCP should be configured to restrict where connections come in from.

```
rails s --port=3000 --binding=0.0.0.0
```

## Thoughts
CloudSQL or Docker for Redis and Postgres?

