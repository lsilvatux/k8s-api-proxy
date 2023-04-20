# K8s API Proxy

This repository is only to create a usable image for using GKE private clusters (https://cloud.google.com/kubernetes-engine/docs/archive/creating-kubernetes-engine-private-clusters-with-net-proxies). The image generation is automatic and you can use in your own project.


### How to use

You need create a service and a deployment inside a GKE cluster to connect. 

```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

To connect the cluster using the proxy you need the IP address of the service created and configure your `.kube/config` the follow parameter:

```
  cluster:
    proxy-url: http://<SERVICE_IP>:8118
    server: https://<GKE-INTERNAL-IP>
```

You may specify the cluster IP for the proxy use, if you want to do this include this in deployment.yaml:

```
        env:
         - name: K8S_IP
           value: "x.y.w.z"
```
