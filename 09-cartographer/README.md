# 09 - Cartographer

Let's start by creating a Kubernetes cluster. I'll use DigitalOcean.

```shell
doctl k8s cluster create devex-cluster \
    --node-pool "name=basicnp;size=s-2vcpu-4gb;count=3;label=type=basic;" \
    --region ams3
```

Install [kapp-controller](https://carvel.dev/kapp-controller/).

```shell
kapp deploy -a kapp-controller \
    -f https://github.com/vmware-tanzu/carvel-kapp-controller/releases/latest/download/release.yml \
    --yes
```

Add the Neptunus Platform package repository in a dedicated namespace.

```shell
k create ns package-repo-global
```

```shell
kctrl package repository add -r neptunus-package-repository \
    --url ghcr.io/neptunus-platform/package-repository:0.7.7 \
    --namespace package-repo-global
```

Next, define a `values.yml` file as the following. Make sure you customize it with your own information.

```yaml
packages:
  namespace: "package-repo-global"

cartographer:
  supply_chain_basic:
    registry:
      server: <registry-server>
      repository: <username>/<repo>

contour:
  envoy:
    service:
      type: LoadBalancer

knative:
  eventing:
    default_broker:
      enabled: true
      namespace: default
  serving:
    domain:
      type: real
      name: <domain-url>

kpack:
  kp_default_repository: <registry-server>/<username>/<repo>
  kp_default_repository_username: <username>
  kp_default_repository_password: <password>

namespace_setup:
  registry: 
    server: <registry-server>
    username: <username>
    password: <password>

  namespaces:
    - name: default
      exists: True # If True, the namespace must exist.
    - name: test
      exists: False # If False, the namespace will be created.
```

Then, install the platform packages.

```shell
kctrl package install --package-install application-platform \
    --package application-platform.neptunus.thomasvitale.com \
    --version 0.1.5 \
    --namespace package-repo-global \
    --values-file values.yml
```

## Basic

Navigate to the `basic` folder.

```shell
cd basic/book-service
```

Run Tilt to start the automated inner development loop on Kubernetes.

```shell
tilt up
```

Now you can work with the application, save your changes, and they will be automatically loaded into
the container running in Kubernetes. You can also debug it by attaching a remote debugger from your IDE
to the Pod.
