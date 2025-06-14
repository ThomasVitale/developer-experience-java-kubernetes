# Inner Loop on Kubernetes - Spring Boot

After containerizing an application, we can deploy it to a Kubernetes cluster. We'll use a local cluster provisioned with [`kind`](https://kind.sigs.k8s.io).

From the root folder of this repository, run the following:

```shell
./create-cluster.sh
```

## Basic

Navigate to the `basic` folder.

```shell
cd basic
```

Package the application as a container image.

```shell
./gradlew bootBuildImage
```

Then load the image to the local cluster. Due to some issues with the `kind` CLI, you need to run the command twice to ensure the image is loaded correctly.

```shell
kind load docker-image demo --name devex-cluster
```

Finally, deploy the application as follows with [`kapp`](https://carvel.dev/kapp/docs/latest/install).

```shell
kapp deploy -a demo -f config -y
```

You can now test the application with [`httpie`](https://httpie.io).

```shell
http :9090/books
```

When you're done, you can undeploy the application as follows:

```shell
kapp delete -a demo -y
```

## JKube

Navigate to the `jkube` folder.

```shell
cd jkube
```

Package the application as a container image.

```shell
./gradlew bootBuildImage
```

Then load the image to the local cluster. Due to some issues with the `kind` CLI, you need to run the command twice to ensure the image is loaded correctly.

```shell
kind load docker-image demo --name devex-cluster
```

Next, generate the Kubernetes manifests and deploy the application with JKube.

```shell
./gradlew k8sResource k8sApply
```

You can now test the application with [`httpie`](https://httpie.io).

```shell
http :9090/books
```

When you're done, you can undeploy the application as follows:

```shell
./gradlew k8sUndeploy
```

## Knative

Let's use a local cluster provisioned with [`kind`](https://kind.sigs.k8s.io) and the [Knative quickstart](https://knative.dev/docs/getting-started/quickstart-install/) to set up Knative.

```shell
kn quickstart kind --registry
```

Navigate to the `knative` folder.

```shell
cd knative
```

Then, you can containerize and publish the application image to a container registry. I have already done that and the image is available on my GitHub Container Registry: `ghcr.io/thomasvitale/devex/book-service`. You can use it to deploy the application on Knative from a YAML manifest. Update `config/knative.yml` with your own image, then run the following command.

```shell
kapp deploy -a demo -f config -y
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

## Tilt

The inner development loop on Kubernetes requires several steps: compiling the application, building the image, loading it to the cluster, and deploying it. We'll automate it with Tilt.

Navigate to the `tilt` folder.

```shell
cd tilt
```

Run Tilt to start the automated inner development loop on Kubernetes.

```shell
tilt up
```

Now you can work with the application, save your changes, and they will be automatically loaded into the container running in Kubernetes. You can also debug it by attaching a remote debugger from your IDE to the Pod.

The Tilt setup in the `Tiltfile` is tuned to work with Visual Studio Code without any additional configuration. 

If you use IntelliJ IDEA, refer to the [official documentation](https://www.jetbrains.com/help/idea/spring-boot.html#application-update-policies) to enable live reload in the IDE. You also need to update the `Tiltfile` and change the folders monitored by Tilt for the live reload functionality. For more information on how it works, refer to the Paketo [official documentation](https://paketo.io/docs/howto/java/#enable-process-reloading).

```python
custom_build(
    # Name of the container image
    ref = 'demo',
    # Command to build the container image
    # On Windows, replace $EXPECTED_REF with %EXPECTED_REF%
    command = './gradlew bootBuildImage --imageName $EXPECTED_REF',
    # Files to watch that trigger a new build
    deps = [ 'build.gradle', './build/classes/java/main', './build/resources/main' ],
    # Enables live reload
    live_update = [
        sync('./build/classes/java/main', '/workspace/BOOT-INF/classes'),
        sync('./build/resources/main', '/workspace/BOOT-INF/classes')
    ]
)
```

## Skaffold

The inner development loop on Kubernetes requires several steps: compiling the application, building the image, loading it to the cluster, and deploying it. We'll automate it with Skaffold.

> **Warning**
> Skaffold support for ARM64 architectures is not available for all build options. The native Buildpacks support is not available for ARM64 architectures, so we're going to configure Skaffold to rely on Spring Boot's Buildpacks support instead.

Navigate to the `skaffold` folder.

```shell
cd skaffold
```

Run Skaffold to start the automated inner development loop on Kubernetes.

```shell
skaffold dev --port-forward
```

Now you can work with the application, save your changes, and they will be automatically loaded into the container running in Kubernetes. You can also debug it by attaching a remote debugger from your IDE to the Pod by starting Skaffold with `skaffold debug`.

## Clean-up

When you're done, delete the cluster by running the following command from the root folder of this repository.

```shell
./destroy-cluster.sh
```
