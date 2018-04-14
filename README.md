# Edmakas_infra
## 4. SSH bastion
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
### Utility gcloud
#### gloud command with parameter startup-script
```
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata-from-file  startup-script='./startup_script.sh'
```
#### creating firewall rule using gloud
```
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --description "Allow incoming traffic on TCP port 9292" --direction INGRESS --target-tags puma-server
```
testapp_IP = 35.189.225.133

testapp_port = 9292

## 6. Packer
### Creating of GCP image using Packer
#### 6.1 What was done

- scripts deploy.sh  install_mongodb.sh  install_ruby.sh  startup_script.sh moved into folder config-scripts 
- created folder packer and subfolder scripts
- created packer template ubunut16.json, some variables have to be set in variables.json.example
- added optional parameters for GCP images as image_description, disk_size, network. tags

## 7. Terraform-1
### Using of terraform for managing IaC 
#### 7.1 What was done
 - создан каталог terraform
 - в terraform созданы конфигурации tf для автоматизированного развертывания VM в GCP
#### 7.2 How to run the project
 - создать файл terraform.tfvars и задать в нем значения переменных tf (пример в terraform.tfvars.example);
 - выполнить terraform apply
 ### 7.3 How to check
  - Выполнтиь terraform output app_external_ip
  - в веб-браузерe перейти по адресу указанному в выводе команды. В окне веб браузера отобразится установленное приложение.
 #### Task co *
  - Для добавления ssh ключа нового пользователя я воспользовался ресурсом google_compute_project_metadata_item
  ```
  resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}"
}
```
- Terraform ничего не знает про метаданные добавленные другими способамиe и после запуска terraform apply пользователь будет удален


## 8. Homework-8: Terraform-2
### 8.1 What was done
- созданы два описания конфигурации образа для packer (app.json, db.json)
- созданы 2 конфигурации TF для app и db;
- конфигурация и деплой приложения и db, а также сетевые настройки предаставлены в виде модулей (app, db, vpc);
- созданы два окружения **stage** (доступный с ограниченного числа IP-адресов), и **prod**, доступный всем;
- создана когфигурация storage-bucket.tf для создания бакетов в GCS;



### 8.2 How to run the project

- cd packer
  - выполнить `packer build -var-file=variables.json app.json`
  - выполнить `packer build -var-file=variables.json db.json`
- cd terraform/{prod,stage}
  - для stage в **main.tf** необходио задать значние source_ranges = ["внешний-IP"]`
  - выполняем `terraform init` для установки нужных модулей и провайдеров, можно просто `terraform get` в случае если провайдеры уже установлены.
  - создать файл terraform.tfvars и задать в нем значения переменных tf  (пример заполнения в terraform.tfvars.example);
  - выполнить `terraform plan`, убедится в отсутсвии ошибок;
  - выполнить `terraform apply`
- Done!


### 8.4 How to check

Выполнтиь `terraform output app_external_ip`

С использованием веб-браузера перейти по адресу указанному в выводе команды.
В окне веб браузера отобразится установленное приложение.

## 9. Ansible-1
