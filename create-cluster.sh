#!/bin/sh

set -euo pipefail

echo "\n📦 Initializing Kubernetes cluster..."

kind create cluster --config kind-config.yml

echo "\n🔌 Installing Contour Ingress..."

kubectl apply -f https://projectcontour.io/quickstart/contour.yaml 

sleep 5

kubectl wait --namespace projectcontour \
  --for=condition=ready pod \
  --selector=app=contour \
  --timeout=60s

kubectl wait --namespace projectcontour \
  --for=condition=ready pod \
  --selector=app=envoy \
  --timeout=60s

echo "\n⛵ Happy Sailing!\n"
