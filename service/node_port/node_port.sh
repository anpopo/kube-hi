kubectl apply -f service/node_port/service.yaml
kubectl apply -f service/deployment.yaml

kubectl get all -l project=snackbar -n snackbar

kubectl get svc -n snackbar -o wide

kubectl get endpoints -n snackbar -o wide

# gcloud 포트 허용 정책 설정 - order 서비스의 NodePort 포트에 대한 방화벽 해제
gcloud compute firewall-rules create order --allow tcp:31542

export ORDER=<node-expernal-ip>:<service-node-port>

curl http://$ORDER/menus
curl -s --request POST http://$ORDER/checkout \
--header 'Content-Type: application/json' \
--data-raw '{
"Pizza": 1, "Coke": 1, "Burger": 1, "Juice": 0}'

# gcloud 포트 허용 정책 확인
gcloud compute firewall-rules list

# 생성했던 gcloud 포트 허용 정책 삭제
gcloud compute firewall-rules delete order    

kubectl delete all -n snackbar -l project=snackbar