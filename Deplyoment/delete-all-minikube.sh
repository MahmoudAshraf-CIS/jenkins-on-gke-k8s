#!/bin/bash
kubectl delete -f serviceAccount.yaml
 
kubectl delete -f deployment-minikube.yaml 
kubectl delete -f service.yaml 
kubectl delete namespace devops-tools 