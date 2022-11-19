Based on Jenkins documentation [here](https://www.jenkins.io/doc/book/installing/kubernetes/)

# Kubernetes Manifests for Jenkins Deployment

Refer https://devopscube.com/setup-jenkins-on-kubernetes-cluster/ for step by step process to use these manifests.

The same deployment of the official documentation, just instead of using [`jenkins/jenkins:lts`](https://hub.docker.com/r/jenkins/jenkins) am using [`mnnsashraf/custom-jenkins-docker:latest`](https://hub.docker.com/r/mnnsashraf/custom-jenkins-docker)

see [deployment.yaml](deployment.yaml?plain=1#L22)


Deploy to Kubernetes cluster


```cli
kubectl create namespace devops-tools
kubectl apply -f serviceAccount.yaml
```
For the sake of simplicity, am assuming Jenkins data will be stored on a persistent volume on the host node
before proceeding you need to get the node name 

```cli
kubectl get nodes
```

[Set the values at volume.yaml](volume.yaml?plain#L33)


```
kubectl create -f volume.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get pods --namespace=devops-tools
kubectl exec -it jenkins-7c479cdcd9-t2k5b cat /var/jenkins_home/secrets/initialAdminPassword -n devops-tools

```

