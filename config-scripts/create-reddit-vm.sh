#!/bin/bash
image=$(gcloud compute images list | grep reddit-full| sort -r| head -1| cut -f 1 -d ' ')


gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --machine-type=g1-small --tags puma-server --restart-on-failure --metadata-from-file  startup-script='./startup_script.sh'



