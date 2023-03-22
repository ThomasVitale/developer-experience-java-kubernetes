# Developer Experience with Java on Kubernetes

In the cloud-native world, being a developer might be challenging. The number of technologies and patterns to know can be overwhelming. This repository presents an approach based on open-source technologies and focused on improving the inner development loop and continuous delivery on Kubernetes. The end goal is delivering value continuously, quickly, and reliably.

The approach works with any Java application, but we'll use Spring Boot for our examples. Some of the open-source technologies covered are:

* Cloud Native Buildpacks
* Knative
* Tilt
* Skaffold
* Telepresence
* Argo CD
* Cartographer.

For each tool/strategy there is a dedicated folder within which you'll find instructions on how to setup your environment.

## Pre-requisites

Running through the examples will require you to have the following installed on your machine:

* [Java 17](https://adoptium.net/en-GB/temurin/releases)
* [Podman](https://podman-desktop.io)
* [kubectl](https://kubectl.docs.kubernetes.io)
* [kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
* [kapp](https://carvel.dev/kapp/docs/latest/install)

To manage different versions and distributions of Java, I recommend using [SDKMAN!](https://sdkman.io).

Finally, to interact with HTTP services, I recommend using [httpie](https://httpie.io).
