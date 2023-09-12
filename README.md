# Fudex-Deployment-stack

## Cloning The the Repo
You could clone the repo using this commandLine
#### Clone Fudex-Deploy-stack
```
git clone git@github.com:AhmedSherif-rf/DevOps-Depl-Fudex.git
```

#### Switch to the repo path
```
cd DevOps-Depl-Fudex
```
### adjust some permissions 
you may need to adjust the permissions of the script files depends on the user that you're using 
#### CommandLine to adjust the permission
```
chmod 777 depl.sh
```
## Docker as a prerequiste 
You need to make sure that you have Docker engine service is already installed or not 
#### Check status of Docker
```
systemctl status docker
systemctl start docker
```
## Starting the Application 
```
docker-compose up -d 
```

