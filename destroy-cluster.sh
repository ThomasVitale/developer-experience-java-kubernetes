#!/bin/sh

echo "\n🏴‍☠️ Destroying Kubernetes cluster..."

KIND_EXPERIMENTAL_PROVIDER=podman kind delete cluster --name devex-cluster

echo "\n🏴‍☠️ Cluster destroyed\n"
