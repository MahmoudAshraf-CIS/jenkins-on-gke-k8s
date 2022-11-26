#!/bin/bash
kubectl delete namespace devops-tools &&
kubectl delete -f serviceAccount.yaml &&
kubectl delete -f volume.yaml &&
kubectl delete -f deployment.yaml &&
kubectl delete -f service.yaml 