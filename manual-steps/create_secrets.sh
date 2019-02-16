#!/bin/bash

if [[ -z "$DOMAIN" ]]; then
  echo ".env does not appear to be sourced, sourcing now"
  . ../.env
fi

kseal() {
    name=$(basename -s .txt "$@")
    if [[ -z "$NS" ]]; then
      NS=default
    fi
    envsubst < "$@" > values.yaml | kubectl -n "$NS" create secret generic "$name" --from-file=values.yaml --dry-run -o json | kubeseal --format=yaml --cert=../pub-cert.pem && rm values.yaml
}

#################
# secrets
#################
# kubectl create secret generic fluxcloud --from-literal=slack_url="$SLACK_WEBHOOK_URL" --namespace flux --dry-run -o json | kubeseal --format=yaml --cert=../pub-cert.pem > ../secrets/fluxcloud.yaml
# kubectl create secret generic traefik-basic-auth-jeff --from-literal=auth="$JEFF_AUTH" --namespace kube-system --dry-run -o json | kubeseal --format=yaml --cert=../pub-cert.pem > ../secrets/basic-auth-jeff-kube-system.yaml
# kubectl create secret generic traefik-basic-auth-jeff --from-literal=auth="$JEFF_AUTH" --dry-run -o json | kubeseal --format=yaml --cert=../pub-cert.pem > ../secrets/basic-auth-jeff.yaml
# kubectl create secret generic restic-secret --from-literal=RESTIC_PASSWORD="$RESTIC_PASSWORD" --dry-run -o json | kubeseal --format=yaml --cert=../pub-cert.pem > ../secrets/restic-secret.yaml
# kubectl create secret generic restic-secret --from-literal=RESTIC_PASSWORD="$RESTIC_PASSWORD" --namespace kube-system --dry-run -o json | kubeseal --format=yaml --cert=../pub-cert.pem > ../secrets/restic-secret-kube-system.yaml
# kubectl create secret generic restic-secret --from-literal=RESTIC_PASSWORD="$RESTIC_PASSWORD" --namespace logs --dry-run -o json | kubeseal --format=yaml --cert=../pub-cert.pem > ../secrets/restic-secret-logs.yaml
# kubectl create secret generic ceph-admin-secret --from-literal=auth="$EXTERNAL_CEPH_ADMIN_SECRET" --namespace kube-system --dry-run -o json | kubeseal --format=yaml --cert=../pub-cert.pem > ../secrets/external-ceph-admin-secret-kube-system.yaml
# kubectl create secret generic ceph-secret --from-literal=auth="$EXTERNAL_CEPH_SECRET" --namespace kube-system --dry-run -o json | kubeseal --format=yaml --cert=../pub-cert.pem > ../secrets/external-ceph-secret-kube-system.yaml



###################
# helm chart values
###################

# NS=kube-system kseal values-to-encrypt/consul-values.txt > ../secrets/consul-values.yaml
# NS=kube-system kseal values-to-encrypt/traefik-values.txt > ../secrets/traefik-values.yaml
NS=kube-system kseal values-to-encrypt/kubernetes-dashboard-values.txt > ../secrets/kubernetes-dashboard-values.yaml
# NS=kube-system kseal values-to-encrypt/kured-values.txt > ../secrets/kured-values.yaml
# NS=kube-system kseal values-to-encrypt/forwardauth-values.txt > ../secrets/forwardauth-values.yaml

# NS=logs kseal values-to-encrypt/kibana-values.txt > ../secrets/kibana-values.yaml


kseal values-to-encrypt/influxdb-values.txt > ../secrets/influxdb-values.yaml
# kseal values-to-encrypt/chronograf-values.txt > ../secrets/chronograf-values.yaml
# kseal values-to-encrypt/prometheus-values.txt > ../secrets/prometheus-values.yaml
# kseal values-to-encrypt/hubot-values.txt > ../secrets/hubot-values.yaml
# kseal values-to-encrypt/comcast-values.txt > ../secrets/comcast-values.yaml
# kseal values-to-encrypt/uptimerobot-values.txt > ../secrets/uptimerobot-values.yaml
# kseal values-to-encrypt/grafana-values.txt > ../secrets/grafana-values.yaml
# kseal values-to-encrypt/minio-values.txt > ../secrets/minio-values.yaml
# kseal values-to-encrypt/rtorrent-flood-values.txt > ../secrets/rtorrent-flood-values.yaml
# kseal values-to-encrypt/nzbget-values.txt > ../secrets/nzbget-values.yaml
# kseal values-to-encrypt/plex-values.txt > ../secrets/plex-values.yaml
# kseal values-to-encrypt/radarr-values.txt > ../secrets/radarr-values.yaml
# kseal values-to-encrypt/sonarr-values.txt > ../secrets/sonarr-values.yaml
# kseal values-to-encrypt/hass-values.txt > ../secrets/hass-values.yaml
# kseal values-to-encrypt/hass-mysql-values.txt > ../secrets/hass-mysql-values.yaml
# kseal values-to-encrypt/unifi-values.txt > ../secrets/unifi-values.yaml
# kseal values-to-encrypt/node-red-values.txt > ../secrets/node-red-values.yaml
# kseal values-to-encrypt/rabbitmq-values.txt > ../secrets/rabbitmq-values.yaml
# kseal values-to-encrypt/nextcloud-values.txt > ../secrets/nextcloud-values.yaml