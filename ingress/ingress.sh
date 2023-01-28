kubectl apply -f ingress/backend

kubectl get all -n snackbar

kubectl get endpoints

# 여러 호스트로 규칙을 설정한 인그래스 배포
kubectl apply -f ingress/ingress_multiple_host.yaml

# 인그레스 리소스 확인 - ADDRESS: Ingress Controller 의 IP 
kubectl get ingress -n snackbar

# 인그레스 컨트롤러 아이피 확인
kubectl get ingress -n snackbar -o jsonpath="{.status.loadBalancer.ingress[0].ip}"

# 인그레스 아이피 환경변수 등록
export INGRESS_IP=$(kubectl get ingress/snackbar -n snackbar -o jsonpath="{.status.loadBalancer.ingress[0].ip}")

# 여러 호스트 인그레스 테스트 ----------------------------------------
# 각 요청의 헤더에 있는 Host 를 ingress_multiple_host.yaml 에 설정된 규칙에 맞게 보내고 해당하는 호스트가 없는 경우 defaultBackend 에 설정된 서비스로 라우딩 한다.
curl -s -H "Host: order.fast-snackbar.com" --request GET $INGRESS_IP/menus

curl -H "Host: order.fast-snackbar.com" --request POST http://$INGRESS_IP/checkout \
--header 'Content-Type: application/json' \
--data-raw '{
"Pizza": 1, "Coke": 1, "Burger": 1, "Juice": 0}'

curl -s -H "Host: payment.fast-snackbar.com" --request GET $INGRESS_IP

curl -H "Host: payment.fast-snackbar.com" -s --request POST http://$INGRESS_IP/receipt \
--header 'Content-Type: application/json' \
--data-raw '{
"Pizza": 1, "Coke": 1, "Burger": 1, "Juice": 0}' | json_pp

curl -s -H "Host: delivery.fast-snackbar.com" --request GET $INGRESS_IP

curl -s -H "Host: wrong.fast-snackbar.com" --request GET $INGRESS_IP
# -----------------------

# 여러 호스트 규칙을 가진 인그레스 정리 
kubectl delete ingress snackbar -n snackbar 


# 단일 호스트에 path 로 라우팅 규칙을 가지는 인그레스 배포 ---------------------------
kubectl apply -f ingress/ingress_single_host.yaml

# 인그레스 아이피 환경변수 등록
export INGRESS_IP=$(kubectl get ingress/snackbar -n snackbar -o jsonpath="{.status.loadBalancer.ingress[0].ip}")

curl -s  --request GET $INGRESS_IP/order/menus

curl -s --request POST http://$INGRESS_IP/order/checkout \
--header 'Content-Type: application/json' \
--data-raw '{
"Pizza": 1, "Coke": 1, "Burger": 1, "Juice": 0}'

curl -s --request GET $INGRESS_IP/payment

curl  -s --request POST http://$INGRESS_IP/payment/receipt \
--header 'Content-Type: application/json' \
--data-raw '{
"Pizza": 1, "Coke": 1, "Burger": 1, "Juice": 0}' | json_pp

curl -s --request GET $INGRESS_IP/delivery

curl -s  --request GET $INGRESS_IP/wrong

# 여러 호스트 규칙을 가진 인그레스 정리 
kubectl delete ingress snackbar -n snackbar 

# 모든 자원 정리
kubectl delete all -n snackbar -l project=snackbar