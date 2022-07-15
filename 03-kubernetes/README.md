# 03 - Kubernetes

After containerizing an application, we can deploy it to a Kubernetes cluster. We'll use a local cluster provisioned with [`kind`](https://kind.sigs.k8s.io).

```shell
cd ..
./create-cluster.sh
```

## Basic

Navigate to the `basic` folder.

```shell
cd basic/book-service
```

Package the application as a container image.

```shell
./gradlew bootBuildImage
```

Then load the image to the local cluster.

```shell
kind load docker-image book-service --name devex-cluster
```

Finally, deploy the application as follows with [`kubectl`](https://kubectl.docs.kubernetes.io).

```shell
kubectl apply -f config
```

You can now test the application with [`httpie`](https://httpie.io).

```shell
http localhost/books
```

## Live Reload

Paketo, the Cloud Native Buildpacks implementation we used above, provides support for live-reload.
You can enable it via the `BP_LIVE_RELOAD_ENABLED` environment variable. Then, you need a tool like
Spring Boot DevTools to take care of loading into the images the changed classes every time they are updated.

## Clean-up

When you're done, delete the cluster as follows.

```shell
cd ..
./destroy-cluster.sh
```
