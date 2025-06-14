# Inner Loop on Java - Spring Boot

Let's start by defining a baseline for our development experience. We'll use test-driven development and run the application locally on the JVM.

## Basic

The [Spring Boot Developer Tools](https://docs.spring.io/spring-boot/docs/current/reference/html/using.html#using.devtools) library provides live-reload capabilities when working on the application locally.

Navigate to the `basic` folder.

```shell
cd basic
```

Run the application on the local JVM as follows.

```shell
./gradlew bootRun
```

Now, try making some changes to the application (for example, updating the REST API) and save. Spring Boot Developer Tools will automatically reload the application with the new classes.

If you use Visual Studio Code, the live reload functionality works without any additional configuration.

If you use IntelliJ IDEA, refer to the [official documentation](https://www.jetbrains.com/help/idea/spring-boot.html#application-update-policies) to enable support for Spring Boot DevTools in the IDE.

## Container Image

Let's explore how to package Java applications as container images. We'll see how to use Dockerfiles and Cloud Native Buildpacks.

### Dockerfile

Navigate to the `container-image/dockerfile` folder.

```shell
cd container-image/dockerfile
```

Then, package the application as a JAR.

```shell
./gradlew bootJar
```

Finally, package the application as a container image using the provided Dockerfile.

```shell
podman build -f Dockerfile -t demo .
```

You can run the application on Podman as follows.

```shell
podman run --rm -p 8080:8080 demo
```

Similarly, you can use Docker instead of Podman.

### Cloud Native Buildpacks

Navigate to the `container-imagebuildpacks` folder.

```shell
cd container-image/buildpacks
```

You can use the [`pack`](https://buildpacks.io/docs/tools/pack/) CLI from the Cloud Native Buildpacks project to package the application as a container image.

```shell
pack build demo
```

For Spring Boot projects, Buildpacks integration is provided directly by the Spring Boot plugins for [Maven](https://docs.spring.io/spring-boot/docs/current/maven-plugin/reference/htmlsingle/#build-image) and [Gradle](https://docs.spring.io/spring-boot/docs/current/gradle-plugin/reference/htmlsingle/#build-image), so you don't need to install any additional tool.

```shell
./gradlew bootBuildImage
```

## Compose

Either way, you can run the application as follows.

```shell
podman compose up -d
```

You can also debug the application from your IDE. Check out the configuration in the `compose.yml` file, where the debug mode is enabled via convenient Buildpacks environment variables. Then, configure your IDE with a remote debugger on port `9090` and try out debugging the application while running as a container.

When you're done, you can stop the application with the following command.

```shell
podman compose down
```
