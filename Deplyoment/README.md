Based on Jenkins documentation [here](https://www.jenkins.io/doc/book/installing/kubernetes/)

# Kubernetes Manifests for Jenkins Deployment

Refer https://devopscube.com/setup-jenkins-on-kubernetes-cluster/ for step by step process to use these manifests.

The same deployment of the official documentation, just instead of using [`jenkins/jenkins:lts`](https://hub.docker.com/r/jenkins/jenkins) am using [`mnnsashraf/custom-jenkins-docker:latest`](https://hub.docker.com/r/mnnsashraf/custom-jenkins-docker)

see [deployment.yaml](deployment.yaml?plain=1#L22)
<br>
<br>
<br>
Known Issue deploying large image on k8s may raise an error 
<br> 
`context deadline exceeded`
<br>
To solve the issue on minikube [see reference](https://serverfault.com/questions/1107050/context-deadline-exceeded-error-on-pod-in-kubernetes-while-pulling-a-public-im)

```cli
> minikube ssh docker pull <the_image>mnns/custom-jenkins-docker:latest
```
<br>

### Deploy

1. #### On Google Kubernetes cluster
   

```cli
    > git clone https://github.com/MahmoudAshraf-CIS/jenkins-on-gke-k8s
    > bash apply-all-gcp.sh
```

2. #### On minikube cluster
   

```cli
    > git clone https://github.com/MahmoudAshraf-CIS/jenkins-on-gke-k8s
    > bash apply-all-minikube.sh
```


-----

### Get Jenkins initial admin password

```cli
> kubectl get pods --namespace=devops-tools
NAME                      READY   STATUS    RESTARTS   AGE
jenkins-b96f7764f-9qx99   0/1     Pending   0          5m19s
```

```
> kubectl exec -it jenkins-b96f7764f-9qx99 cat /var/jenkins_home/secrets/initialAdminPassword -n devops-tools
```



 

-----

### Delete all resources
1. #### On Google Kubernetes cluster
 ```cli
    > bash delete-all-gcp.sh
```
2. #### On Minikube cluster
 
```cli
    > bash delete-all-minikube.sh
```
