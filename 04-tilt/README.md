# 04 - Tilt

The inner loop on Kubernetes requires several steps: building the image, loading it to the cluster, and deploying it. We'll automate it with Tilt.

Let's use a local cluster provisioned with [`kind`](https://kind.sigs.k8s.io).

```shell
cd ..
./create-cluster.sh
```

## Basic

Navigate to the `basic` folder.

```shell
cd basic/book-service
```

Run Tilt to start the automated inner development loop on Kubernetes.

```shell
tilt up
```

Now you can work with the application, save your changes, and they will be automatically loaded into
the container running in Kubernetes. You can also debug it by attaching a remote debugger from your IDE
to the Pod.

## Clean-up

When you're done, delete the cluster as follows.

```shell
cd ..
./destroy-cluster.sh
```
