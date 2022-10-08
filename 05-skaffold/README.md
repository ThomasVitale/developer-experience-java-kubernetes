# 05 - Skaffold

The inner development loop on Kubernetes requires several steps: compiling the application, building the image, loading it to the cluster, and deploying it. We'll automate it with Skaffold.

Let's use a local cluster provisioned with [`kind`](https://kind.sigs.k8s.io).

```shell
cd ..
./create-cluster.sh
```

## Basic

Navigate to the `basic` folder.

```shell
cd 05-skaffold/basic/book-service
```

Run Skaffold to start the automated inner development loop on Kubernetes.

```shell
skaffold dev --port-forward
```

Now you can work with the application, save your changes, and they will be automatically loaded into
the container running in Kubernetes. You can also debug it by attaching a remote debugger from your IDE
to the Pod by starting Skaffold with `skaffold debug`.

## Clean-up

When you're done, delete the cluster as follows.

```shell
cd ../../..
./destroy-cluster.sh
```