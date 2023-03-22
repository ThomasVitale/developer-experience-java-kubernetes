# 09 - Cartographer

In this section we'll see how [Cartographer](https://cartographer.sh) can be used to design and build golden paths to production and enhance the developer experience, while reducing cognitive load and providing a clear separation of concerns between product teams and platform team.

For this example, we need a Kubernetes cluster provisioned in the cloud. I'll use DigitalOcean, but feel free another provider.

```shell
doctl k8s cluster create devex-cluster \
    --node-pool "name=basicnp;size=s-2vcpu-4gb;count=3;label=type=basic;" \
    --region ams3
```

We'll also need the following CLI tools:

* [cosign](https://docs.sigstore.dev/cosign/installation)
* [kapp](https://carvel.dev/kapp/docs/latest/install)
* [kctrl](https://carvel.dev/kapp-controller/docs/latest/install/#installing-kapp-controller-cli-kctrl)
* [carto](https://github.com/ThomasVitale/cartographer-cli)

Then, install [kapp-controller](https://carvel.dev/kapp-controller), the component providing Kubernetes-native package management capabilities. 

```shell
kapp deploy -a kapp-controller -y \
  -f https://github.com/carvel-dev/kapp-controller/releases/latest/download/release.yml
```

Add the [Kadras](https://github.com/kadras-io/kadras-packages) package repository in a dedicated namespace.

```shell
kubectl create ns kadras-packages
```

```shell
kctrl package repository add -r kadras-packages \
    --url ghcr.io/arktonix/kadras-packages:0.9.1 \
    --namespace kadras-packages
```

Then, create a key-pair used by Cosign to sign container images and other artifacts.

```shell
kubectl create ns secrets-management
cosign generate-key-pair k8s://secrets-management/cosign-key-pair
```

Next, define a `values.yml` file as the following. Make sure you customize it with your own information.
For example, `<registry-server>` could be `ghcr.io` or `docker.io` whereas `<git-server>` could be `https://github.com`.

```yaml
packages:
  namespace: "kadras-packages"

buildpacks:
  catalog:
    kp_default_repository:
      name: <registry-server>/<username>/<repo>
  kpack:
    kp_default_repository:
      name: <registry-server>/<username>/<repo>
      credentials:
        username: <username>
        password: <password>

cartographer:
  supply_chains:
    supply_chain: basic
    registry:
      server: <registry-server>
      repository: <username>/<repo>

contour:
  certificates:
    useCertManager: true

knative:
  serving:
    config:
      domain:
        name: <domain-url>
      network:
        domain-template: "{{.Name}}-{{.Namespace}}.{{.Domain}}"
    tls:
      certmanager:
        clusterissuer: kadras-ca-issuer

namespace_setup:
  gitops:
    server: <git-server>
    username: <username>
    password: <password>

  registry: 
    server: <registry-server>
    username: <username>
    password: <password>

  namespaces:
    - name: default
      exists: True
```

Then, install the Kadras [Engineering Platform](https://github.com/kadras-io/engineering-platform) packages.

```shell
kctrl package install -i engineering-platform \
  -p engineering-platform.packages.kadras.io \
  -v 0.7.1 \
  -n kadras-packages \
  --values-file values.yml
```

After the installation, you should configure the DNS for your domain so that what you wrote as `<domain-url>` is mapped to the IP address of the load balancer provisioned for the platform. You can retrieve the IP address from the "External IP" value returned by the following command. Note that it can take a few minutes for the cloud provider to provision the load balancer and assign an IP address.

```shell
kubectl get svc envoy -n projectcontour
```

## Basic

Navigate to the `basic` folder.

```shell
cd basic/book-service
```

Open the Tiltfile and update the `SOURCE_IMAGE` variable in the first line to point to your container registry. Also, update the value passed to the `allow_k8s_contexts()` method in the last line so that it matches the name of your Kubernetes cluster context.

Run Tilt to start the automated inner development loop on Kubernetes.

```shell
tilt up
```

Now you can work with the application, save your changes, and they will be automatically loaded into
the container running in Kubernetes. You can also debug it by attaching a remote debugger from your IDE
to the Pod.

You can follow the work done by the platform to initiate the inner development loops from the Tilt GUI or with the following command:

```shell
carto apps workload get book-service
```

The workflow is governed by the `Workload` definition in `config/workload.yml`. In the cluster, [Cartographer](https://cartographer.sh) has been used to define a [golden path to production for web applications](https://github.com/kadras-io/cartographer-supply-chains), including monitoring the application source code for changes with [Flux](https://fluxcd.io), containerizing the application with [kpack](https://github.com/pivotal/kpack) (a Kubernetes-native implementation of Cloud Native buildpacks), and deploying it with [Knative](https://knative.dev/docs/).

When you're done, you can stop the continuous development loop as follows:

```shell
tilt down
```
