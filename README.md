# Edmakas_infra
## HW №4
#### slide on page 35
Host "bastion" works as a gateway for whole hosts with no external IP address
Example of a command to connect to internal host through "bastion":

```bash
ssh -i ~/.ssh/appuser -o ProxyCommand="ssh -i ~/.ssh/appuser -W %h:%p appuser@35.205.144.68" appuser@10.132.0.3 
```
