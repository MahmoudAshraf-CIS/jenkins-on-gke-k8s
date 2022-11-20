
A Docker image that is based on Jenkins base image 

The purpose is to have Jenkins deployed to GKE cluster in a worker node enabling CICD
Jenkins objective here is to trigger the following actions once an update was made on the application repo

- Pull from GitHub repo
- Build a docker image out of the application
- Push the build image to Docker hub registry
- Deploy the new artifact to the GKE cluster

- - - - 
# Making Changes to the image #

Right now the image includes the following
- Docker
- Gcloud
- Kubectl
- Jenkins

if you want to include any other packages other than what is included

you may edit the Docker file then 
### Re-build a new image
```cli
docker image build -t mnnsashraf/custom-jenkins-docker .
```


### Run the image

1. #### In docker container

    Note: this method is relying on Docker-in-docker method 
    their are different methods to do so, but I went with the .sock option
    see [Enabling use of Docker daemon in the Jenkins container](https://hackmamba.io/blog/2022/04/running-docker-in-a-jenkins-container/) section in this articel.

    Make sure docker is installed on the host machine
    ```cli 
    docker --version
    ```
    since the .sock would be used by the container, change the .sock permission

    ```cli
    sudo chmod 777 /var/run/docker.sock
    ```
    this would basically set the file to be read/write/execute for every user.  

    ```cli
    docker run --name custom-jenkins-docker -d -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home mnnsashraf/custom-jenkins-docker
    ```
    
2. #### In K8s cluster 

    ##### `in-line` method is used here but it can also be in .yaml deployment
    [See Guide here](Deplyoment/README.md)
     

    Create a deployment 
    ```cli
    kubectl create deployment jenkins-server --image=mnnsashraf/custom-jenkins-docker
    ```

    then, you may expose the deployment over loadbalancer

    ```cli
    kubectl expose deployment jenkins-server --type LoadBalancer --port=8080,50000 --target-port 8080
    ```
    Open jenkins interface
    ```cli
    http://loadbalancerip
    ```

    get Jenkins pass
    ```cli
    kubectl get pods
    kubectl exec -it <pod name> cat /var/jenkins_home/secrets/initialAdminPassword
    kubectl exec -it jenkins-server-5c4f967578-k9qhb cat /var/jenkins_home/secrets/initialAdminPassword 
    ```

    Open shell in interactive mode 
    ```cli
    kubectl exec -it <pod name> /bin/bash
    kubectl exec -it jenkins-server-5c4f967578-k9qhb /bin/bash
    ```

- - - - 
# Publish to docker hub #

Login to docker hub using your user name and password
```cli
docker login
```
Build and run a container
```cli
docker image build -t custom-jenkins-docker .
```
then run it
```cli
docker run --name custom-jenkins-docker -d -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home custom-jenkins-docker

```

Get the container id
```cli
$ docker ps 
CONTAINER ID   IMAGE                    ...........
d1a2197c1bb9   custom-jenkins-docker    ...........
```

```cli
docker container commit <containet_id> <dockerHubUserName>/custom-jenkins-docker:tag
```

```cli
# Example
docker container commit d1a2197c1bb9 mnnsashraf/custom-jenkins-docker:latest
```
Push to docker hub

```cli
docker push mnnsashraf/custom-jenkins-docker:latest
```

    