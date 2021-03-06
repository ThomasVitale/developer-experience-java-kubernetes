#!/bin/sh

set -euo pipefail

echo "\nš¦ Initializing Kubernetes cluster..."

kind create cluster --config kind-config.yml

echo "\nš Installing NGINX Ingress..."

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "\nš Waiting for NGINX Ingress to be ready..."

sleep 15

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

echo "\nāµ Happy Sailing!\n"