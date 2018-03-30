# Edmakas_infra
## 4. SSH bastion
#### slide on page 35
###### Option 1:
Host "bastion" works as a gateway for whole hosts with no external IP address
Example of a command to connect to internal host through "bastion":

```bash
ssh -i ~/.ssh/appuser -o ProxyCommand="ssh -i ~/.ssh/appuser -W %h:%p appuser@35.205.144.68" appuser@10.132.0.3
```
###### Option 2:
It's convenient to use ~/.ssh/.config to simplify commands using for establishing ssh connectivity
There is an example of such configuration:
```bash
Host someinternalhost
    HostName 10.132.0.3
    IdentityFile ~/.ssh/appuser
    User appuser
    ProxyCommand ssh -A bastion -W %h:%p

Host bastion
    HostName 35.205.144.68
    User appuser
    IdentityFile ~/.ssh/appuser
````
#### Data for verification of OpenVpn configuration
bastion_IP = 35.205.144.68
someinternalhost_IP = 10.132.0.3

## 5. GCP
### utility gcloud
#### gloud command with parameter startup-script
```
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata-from-file  startup-script='./startup_script.sh'
```
#### creating firewall rule using gloud
```
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --description "Allow incoming traffic on TCP port 9292" --direction INGRESS --target-tags puma-server
```
testapp_IP = 35.187.78.119
testapp_port = 9292

## 6. Packer
### Creating of GCP image using Packer
#### 6.1 What was done

- scripts deploy.sh  install_mongodb.sh  install_ruby.sh  startup_script.sh moved into folder config-scripts 
- created folder packer and subfolder scripts
- created packer template ubunut16.json, some variables have to be set in variables.json.example
- added optional parameters for GCP images as image_description, disk_size, network. tags
