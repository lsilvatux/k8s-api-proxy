#!/bin/sh

set -o errexit
set -o pipefail
set -o nounset

# Get the internal cluster IP
export TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)
 
if [ -z ${K8S_IP} ]; then 
K8S_IP=$(curl -H "Authorization: Bearer $TOKEN" -k -SsL https://kubernetes.default/api | jq -r '.serverAddressByClientCIDRs[0].serverAddress')
fi

# Replace CLUSTER_IP in the rewrite filter and action file
sed -i "s/CLUSTER_IP/${K8S_IP}/g"\
 /etc/privoxy/k8s-rewrite-internal.filter
sed -i "s/CLUSTER_IP/${K8S_IP}/g"\
 /etc/privoxy/k8s-only.action

# Start Privoxy un-daemonized
privoxy --no-daemon /etc/privoxy/config
