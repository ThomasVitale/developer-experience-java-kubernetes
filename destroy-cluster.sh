#!/bin/sh

echo "\n🏴‍☠️ Destroying Kubernetes cluster..."

kind delete cluster --name devex-cluster

echo "\n🏴‍☠️ Cluster destroyed\n"