kubectl apply -f service/load_balancer/service.yaml
kubectl apply -f service/deployment.yaml

kubectl get all -n snackbar

kubectl get svc -n snackbar -o wide
kubectl get endpoints -n snackbar

export ORDER=<service-external-ip>

curl http://$ORDER/menus

curl -s --request POST http://$ORDER/checkout \
--header 'Content-Type: application/json' \
--data-raw '{
"Pizza": 1, "Coke": 1, "Burger": 1, "Juice": 0}'

kubectl delete all -n snackbar -l project=snackbar