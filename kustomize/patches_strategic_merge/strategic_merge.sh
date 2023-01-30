kubectl kustomize ./kustomize/patches_strategic_merge/  # dry run describe

kubectl apply -k ./kustomize/patches_strategic_merge/

kubectl get all

kubectl describe deploy my-nginx

kubectl delete --kustomize ./kustomize/patches_strategic_merge/