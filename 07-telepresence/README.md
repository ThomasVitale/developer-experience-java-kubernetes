# 07 - Telepresence

Let's explore how to develop applications on the local JVM while taking advantage of all the services provided by a Kubernetes cluster. We'll use a local cluster provisioned with [`kind`](https://kind.sigs.k8s.io). For this example, you need to install [Telepresence](https://www.telepresence.io/docs/latest/install).

```shell
cd ..
./create-cluster.sh
```

## Basic

Navigate to the `basic` folder.

```shell
cd 07-telepresence/basic/book-service
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

At this point, you can use Telepresence to proxy traffic directed to the Book Service application to your local machine. First, start the Telepresence daemon.

```shell
telepresence connect
```

Then, start proxying traffic to Book Service.

```shell
telepresence intercept book-service --port 8080:http
```

You can now run Book Service locally as follows.

```shell
./gradlew bootRun
```

With Telepresence, you can call the application from the Kubernetes Ingress rather than directly on your local machine. That means the application will benefit from any integration and configuration
applied to the cluster (for example, HTTPS, connections to backing services, databases, security,
and more).

```shell
http localhost/books
```

## Clean-up

When you're done, stop Telepresence.

```shell
telepresence quit
```

Then, delete the cluster as follows.

```shell
cd ../../..
./destroy-cluster.sh
```

## Issues with AMD64

There are some issues with the latest Telepresence version on AMD64 machines, so I'm using an older version there.

```shell
sudo curl -fL https://app.getambassador.io/download/tel2/darwin/arm64/2.5.8/telepresence -o /usr/local/bin/telepresence
```

More information: https://github.com/telepresenceio/telepresence/issues/2596
