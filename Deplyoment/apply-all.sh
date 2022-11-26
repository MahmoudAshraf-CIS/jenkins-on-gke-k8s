#!/bin/bash
kubectl create namespace devops-tools 
kubectl apply -f serviceAccount.yaml 
kubectl create -f volume.yaml 
kubectl apply -f deployment.yaml 
kubectl apply -f service.yaml 

kubectl get deployments -n devops-tools 
kubectl  describe deployments --namespace=devops-tools
