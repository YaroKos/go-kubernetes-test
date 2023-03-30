#k3d cluster create mycluster

## TODO: Docker build and push

## TODO: Deploy k8s manifests


#!/bin/bash

set -e

minikube start

kubectl config use-context minikube

docker build -t yarokos/go-app:latest .

kubectl create namespace myns

helm install go-app-v1 ./go-app --namespace myns

kubectl get all -n myns

kubectl rollout status deployment/api -n myns

if [ $? -eq 0 ]; then

  bash test.sh

fi