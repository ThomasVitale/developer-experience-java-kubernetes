#!/bin/sh

set -euo pipefail

echo "\n📦 Initializing Kubernetes cluster..."

KIND_EXPERIMENTAL_PROVIDER=podman kind create cluster --config kind-config.yml

echo "\n🔌 Installing NGINX Ingress..."

kapp deploy -a ingress-nginx -y \
  -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "\n⛵ Happy Sailing!\n"
