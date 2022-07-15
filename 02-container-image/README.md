# 02 - Container Image

Let's explore how to package Java applications as container images. We'll see how to use Dockerfiles and Cloud Native Buildpacks.

## Basic

Navigate to the `basic` folder.

```shell
cd basic/book-service
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

For Spring Boot projects, Buildpacks integration is provided directly by the Spring Boot plugins for Maven and Gradle, so you don't need to install any additional tool.

```shell
./gradlew bootBuildImage
```

Either way, you can run the application as follows.

```shell
docker run --rm -p 8080:8080 book-service
```

## Live Reload

Paketo, the Cloud Native Buildpacks implementation we used above, provides support for live-reload.
You can enable it via the `BP_LIVE_RELOAD_ENABLED` environment variable. Then, you need a tool like
Spring Boot DevTools to take care of loading into the images the changed classes every time they are updated.
