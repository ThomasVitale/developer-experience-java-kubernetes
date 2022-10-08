# 02 - Container Image

Let's explore how to package Java applications as container images. We'll see how to use Dockerfiles and Cloud Native Buildpacks.

## Basic

Navigate to the `basic` folder.

```shell
cd basic/book-service
```

Then, package the application as a JAR.

```shell
./gradlew bootJar
```

Explore the three different Dockerfiles with different levels of optimizations in terms of performance and security. You can build a container image as follows.

```shell
docker build -f Dockerfile_v3 -t book-service .
```

You can run the application on Docker as follows.

```shell
docker run --rm -p 8080:8080 book-service
```

## Cloud Native Buildpacks

Navigate to the `buildpacks` folder.

```shell
cd buildpacks/book-service
```

You can use the [`pack`](https://buildpacks.io/docs/tools/pack/) CLI from the Cloud Native Buildpacks project to package the application as a container image.

```shell
pack build book-service --builder paketobuildpacks/builder:base --env BP_JVM_VERSION=17
```

On ARM64 machines, use the following.

```shell
pack build book-service --builder ghcr.io/thomasvitale/java-builder-arm64 --env BP_JVM_VERSION=17
```

For Spring Boot projects, Buildpacks integration is provided directly by the Spring Boot plugins for [Maven](https://docs.spring.io/spring-boot/docs/3.0.0-M5/maven-plugin/reference/htmlsingle/#build-image) and [Gradle](https://docs.spring.io/spring-boot/docs/3.0.0-M5/gradle-plugin/reference/htmlsingle/#build-image), so you don't need to install any additional tool.

```shell
./gradlew bootBuildImage
```

Either way, you can run the application as follows.

```shell
docker-compose up -d
```

You can also debug the application from your IDE. Check out the configuration in the `docker-compose.yml` file, where the debug mode is enabled via convenient Buildpacks environment variables. Then, configure your IDE with a remote debugger on port `9090` and try out debugging the application while running as a container.

## Live Reload

Paketo, the Cloud Native Buildpacks implementation we used above, provides support for live-reload.
You can enable it via the `BP_LIVE_RELOAD_ENABLED` environment variable, as demonstrated in `live-reload/book-service/build.gradle`.

Then, you would need a tool like Spring Boot Developer Tools to take care of loading into the images the changed classes every time they are updated. We'll use the live reload capabilities provided by Buildpacks when working with Tilt.
