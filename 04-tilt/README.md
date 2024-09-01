# 04 - Tilt

The inner development loop on Kubernetes requires several steps: compiling the application, building the image, loading it to the cluster, and deploying it. We'll automate it with Tilt.

Let's use a local cluster provisioned with [`kind`](https://kind.sigs.k8s.io).

```shell
cd ..
./create-cluster.sh
```

## Basic

Navigate to the `basic` folder.

```shell
cd 04-tilt/basic/book-service
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
    ref = 'book-service',
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

## Clean-up

When you're done, delete the cluster as follows.

```shell
cd ../../..
./destroy-cluster.sh
```
