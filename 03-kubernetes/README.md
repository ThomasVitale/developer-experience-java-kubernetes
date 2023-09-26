# 03 - Kubernetes

After containerizing an application, we can deploy it to a Kubernetes cluster. We'll use a local cluster provisioned with [`kind`](https://kind.sigs.k8s.io).

```shell
cd ..
./create-cluster.sh
```

## Basic

Navigate to the `basic` folder.

```shell
cd 03-kubernetes/basic/book-service
```

Package the application as a container image.

```shell
./gradlew bootBuildImage
```

Then load the image to the local cluster.

```shell
kind load docker-image book-service --name devex-cluster
```

Finally, deploy the application as follows with [`kapp`](https://carvel.dev/kapp/docs/latest/install).

```shell
kapp deploy -a book-service -f config -y
```

You can now test the application with [`httpie`](https://httpie.io).

```shell
http localhost/books
```

## Clean-up

When you're done, delete the cluster as follows.

```shell
cd ../../..
./destroy-cluster.sh
```
