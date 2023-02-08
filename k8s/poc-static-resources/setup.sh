#!/bin/bash

if ! [ -x "$(command -v kubectl)" ]; then
	echo 'Error: kubectl not found in path.' >&2
	exit 1
fi

for f in cluster-node/*.yaml; do
	echo "kubectl -n coolbeans apply -f $f"
	kubectl -n coolbeans apply -f $f
done

echo "Apply proxy/deployment.yaml"
kubectl -n coolbeans apply -f proxy/deployment.yaml

echo "Installing a Prometheus service to scrape metrics"
for f in prometheus/*.yaml; do
	echo "kubectl -n coolbeans apply -f $f"
	kubectl -n coolbeans apply -f $f
done
