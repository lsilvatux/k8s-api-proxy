#!/bin/sh

set -o errexit
set -o pipefail
set -o nounset

# Get the internal cluster IP
# export TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)
# INTERNAL_IP=$(curl -H "Authorization: Bearer $TOKEN" -k -SsL https://kubernetes.default/api |
# jq -r '.serverAddressByClientCIDRs[0].serverAddress')

# Get external IP (we call internal for tests purposes (= )
INTERNAL_IP=$(curl -SsL --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" https://kubernetes.default/api |
 jq -r '.serverAddressByClientCIDRs[0].serverAddress')

# Replace CLUSTER_IP in the rewrite filter and action file
sed -i "s/CLUSTER_IP/${INTERNAL_IP}/g"\
 /etc/privoxy/k8s-rewrite-internal.filter
sed -i "s/CLUSTER_IP/${INTERNAL_IP}/g"\
 /etc/privoxy/k8s-only.action

# Start Privoxy un-daemonized
privoxy --no-daemon /etc/privoxy/config
