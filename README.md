# K8s API Proxy

This repository is only to create a usable image for using GKE private clusters (https://cloud.google.com/kubernetes-engine/docs/archive/creating-kubernetes-engine-private-clusters-with-net-proxies). The image generation is automatic and you can use in your own project.


### How to use

You need create a service and a deployment inside a cluster to connect. 

```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
