# 06 - Knative

Let's use a local cluster provisioned with [`kind`](https://kind.sigs.k8s.io) and the [Knative quickstart](https://knative.dev/docs/getting-started/quickstart-install/) to set up Knative.

```shell
kn quickstart kind --registry
```

## Basic

Navigate to the `basic` folder.

```shell
cd basic/book-service
```

Then, you can containerize and publish the application image to a container registry. I have already done that and the image is available on my GitHub Container Registry: `ghcr.io/thomasvitale/devex/book-service`. You can use it to deploy the application on Knative from a YAML manifest. Update `config/knative.yml` with your own image, then run the following command.

```shell
kapp deploy -a book-service -f config -y
```

You can retrieve information about the deployment, including the URL where to access the application, with the following command.

```shell
kn service list
```

The result is something like the following.

```shell
NAME           URL                                              LATESTCREATED        LATESTREADY          READY
book-service   http://book-service.default.127.0.0.1.sslip.io   book-service-00001   book-service-00001   True
```

Finally, call the application as follows.

```shell
http book-service.default.127.0.0.1.sslip.io
```

## Clean-up

When you're done, delete the cluster as follows.

```shell
kind delete cluster --name knative
```
