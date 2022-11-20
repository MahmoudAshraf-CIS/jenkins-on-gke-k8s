Based on Jenkins documentation [here](https://www.jenkins.io/doc/book/installing/kubernetes/)

# Kubernetes Manifests for Jenkins Deployment

Refer https://devopscube.com/setup-jenkins-on-kubernetes-cluster/ for step by step process to use these manifests.

The same deployment of the official documentation, just instead of using [`jenkins/jenkins:lts`](https://hub.docker.com/r/jenkins/jenkins) am using [`mnnsashraf/custom-jenkins-docker:latest`](https://hub.docker.com/r/mnnsashraf/custom-jenkins-docker)

see [deployment.yaml](deployment.yaml?plain=1#L22)


Deploy to Kubernetes cluster


```cli
git clone https://github.com/MahmoudAshraf-CIS/jenkins-on-gke-k8s
kubectl create namespace devops-tools
kubectl apply -f serviceAccount.yaml
```
For the sake of simplicity, am assuming Jenkins data will be stored on a persistent volume on the host node
before proceeding you need to get the node name 

```cli
$ kubectl get nodes
NAME                                        STATUS   ROLES    AGE   VERSION
gke-tf-cluster-tf-node-pool-0571c2a0-1fz8   Ready    <none>   22h   v1.23.12-gke.100
```

So you should add `gke-tf-cluster-tf-node-pool-0571c2a0-1fz8`
[on values at volume.yaml](volume.yaml?plain#L33)


Continue the deployment
```cli
kubectl create -f volume.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

Get Jenkins initial admin password

```cli
$ kubectl get pods --namespace=devops-tools
NAME                      READY   STATUS    RESTARTS   AGE
jenkins-b96f7764f-9qx99   0/1     Pending   0          5m19s
```

```
$ kubectl exec -it jenkins-b96f7764f-9qx99 cat /var/jenkins_home/secrets/initialAdminPassword -n devops-tools
```



Extra Commands

Delete all resources under the namespace 
```cli
kubectl delete all --all --namespace=devops-tools
```


```cli
kubectl get pods --namespace=devops-tools
kubectl get services --namespace=devops-tools
kubectl get deployments --namespace=devops-tools
```