Based on Jenkins documentation [here](https://www.jenkins.io/doc/book/installing/kubernetes/)

# Kubernetes Manifests for Jenkins Deployment

Refer https://devopscube.com/setup-jenkins-on-kubernetes-cluster/ for step by step process to use these manifests.

The same deployment of the official documentation, just instead of using [`jenkins/jenkins:lts`](https://hub.docker.com/r/jenkins/jenkins) am using [`mnnsashraf/custom-jenkins-docker:latest`](https://hub.docker.com/r/mnnsashraf/custom-jenkins-docker)

see [deployment.yaml](deployment.yaml?plain=1#L22)


Deploy to Kubernates cluster

```cli
kubectl create namespace devops-tools
kubectl apply -f serviceAccount.yaml
kubectl create -f volume.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get pods --namespace=devops-tools

kubectl exec -it <jenkins-559d8cd85c-NameOfJenkinsContainer> cat /var/jenkins_home/secrets/initialAdminPassword -n devops-tools

```

