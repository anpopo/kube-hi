kubectl kustomize ./kustomize/patches_json_6902/  # dry run describe

kubectl apply -k ./kustomize/patches_json_6902/

kubectl get all

kubectl describe deploy my-nginx

kubectl delete -k ./kustomize/patches_json_6902/