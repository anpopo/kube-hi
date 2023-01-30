kubectl kustomize ./kustomize/default  # dry run describe

kubectl apply --kustomize ./kustomize/default

kubectl delete --kustomize ./kustomize/default