# Edmakas_infra
## HW №4
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

## HW №5
### Работа с gcloud
#### Создание инстанса со startup-script
```
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata-from-file  startup-script='./startup_script.sh'
```
#### Создание правила Firewall`а
```
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --description "Allow incoming traffic on TCP port 9292" --direction INGRESS --target-tags puma-server
```
testapp_IP = 35.187.78.119
testapp_port = 9292
