# 08 - Argo CD

First, set up a Kubernetes environment as explained in the `09-cartographer` folder.

Then, create a Secret in Kubernetes with a token to access your GitHub repository.

```shell
kubectl create secret generic github-token --from-literal=token=<token> -n argocd
```

Finally, update the `applicationset.yml` file to point to a GitHub repository of yours and
apply it to the cluster.

```shell
kubectl apply -f applicationset.yml
```

At this point, whenever you open a pull request to that repository, Argo CD will automatically
deploy the application to the Kubernetes cluster (assuming the image has been built and published
to a container registry). 

You can verify the result from the Argo CD GUI. The username is `admin` and you can find
the password as follows.

```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

Then, open a port forwarding to access the Argo CD GUI.

```shell
kubectl port-forward svc/argocd-server -n argocd 3000:443
```

Now you can login from `http://localhost:3000`.
