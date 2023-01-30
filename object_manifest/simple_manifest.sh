kubectl apply -f object_manifest/deployment.yaml

kubectl get deploy nginx-deployment

kubectl diff -f object_manifest/update_deployment.yaml

kubectl apply -f object_manifest/update_deployment.yaml