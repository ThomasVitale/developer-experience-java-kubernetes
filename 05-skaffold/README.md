# 05 - Skaffold

The inner development loop on Kubernetes requires several steps: compiling the application, building the image, loading it to the cluster, and deploying it. We'll automate it with Skaffold.

> **Warning**
> Skaffold support for ARM64 architectures is not stable. I recommend choosing Tilt over Skaffold in that case.

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

Now you can work with the application, save your changes, and they will be automatically loaded into the container running in Kubernetes. You can also debug it by attaching a remote debugger from your IDE to the Pod by starting Skaffold with `skaffold debug`.

The Skaffold setup in the `skaffold.yml` file is tuned to work with Visual Studio Code without any additional configuration. 

If you use IntelliJ IDEA, refer to the [official documentation](https://www.jetbrains.com/help/idea/spring-boot.html#application-update-policies) to enable live reload in the IDE. You also need to update the `skaffold.yml` file and change the folders monitored by Skaffold for the live reload functionality. For more information on how it works, refer to the Paketo [official documentation](https://paketo.io/docs/howto/java/#enable-process-reloading).

```yaml
apiVersion: skaffold/v4beta10
kind: Config
metadata:
  name: book-service
build:
  artifacts:
    - image: book-service
      buildpacks:
        # Change to docker.io/paketobuildpacks/builder-jammy-base on ARM64
        builder: docker.io/dashaun/builder:base
        trustBuilder: true
        env:
          - BP_JVM_VERSION=21
          - BP_LIVE_RELOAD_ENABLED=true
        dependencies:
          paths:
            - build.gradle
            - src/main/resources
            - build/classes/java/main
            - build/resources/main
      sync:
        manual:
          - src: "src/main/resources/**/*"
            dest: /workspace/BOOT-INF/classes
            strip: src/main/resources/
          - src: "build/classes/java/main/**/*"
            dest: /workspace/BOOT-INF/classes
            strip: build/classes/java/main/
          - src: "build/resources/main/**/*"
            dest: /workspace/BOOT-INF/classes
            strip: build/resources/main/
```

## Clean-up

When you're done, delete the cluster as follows.

```shell
cd ../../..
./destroy-cluster.sh
```
