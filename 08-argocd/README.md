# 08 - Argo CD

Let's see how to use Argo CD to automatically provision temproary environments whenever a new pull request is created on a GitHub repository. We'll use a local cluster provisioned with [`kind`](https://kind.sigs.k8s.io).
For this example, you need to install the [Argo CD CLI](https://argo-cd.readthedocs.io/en/stable/getting_started/#2-download-argo-cd-cli).

```shell
cd ..
./create-cluster.sh
```

## Argo CD

You can install Argo CD with [`kubectl`](https://kubectl.docs.kubernetes.io).

```shell
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Next, use the port forwarding functionality in Kubernetes to expose the Argo CD Server to your local machine.

```shell
kubectl port-forward svc/argocd-server -n argocd 3000:443
```

In a new Terminal window, retrieve the password used to access Argo CD.

```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

Finally, you can access the Argo CD GUI at http://localhost:3000 and login with username `admin` and the password you retrieved in the previous step.

In order to configure Argo CD to monitor a GitHub repository for pull request, we need to create a Secret in Kubernetes with a token. The token can be created from your GitHub account: _Settings > Developer settings > Personal access tokens_. Make sure the token has the following scopes: `repo`.

```shell
kubectl create secret generic github-token --from-literal=token=<token> -n argocd
```

Then, update the `applicationset.yml` file to point to a GitHub repository of yours and
apply it to the cluster.

```shell
kubectl apply -f applicationset.yml
```

At this point, whenever you open a pull request to that repository, Argo CD will automatically
deploy the application to the Kubernetes cluster (assuming the image has been built and published
to a container registry). 

You can verify the result from the Argo CD GUI.

Once the pull request is merged or closed, Argo CD will automatically undeploy the application. For example, try closing the pull request on GitHub and notice how the application disappears from the Argo CD GUI.

## Clean-up

When you're done, delete the cluster as follows.

```shell
cd ../
./destroy-cluster.sh
```
