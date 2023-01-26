# Pod 생성
kubectl apply -f blue-green-app.yaml
kubectl apply -f red-app.yaml

# Pod 정보 보기
# -o 옵션으로 보기 속성 지정 
kubectl get pod -o wide
kubectl get pod/blue-green-app -o json
kubectl get pod/red-app -o wide

# 컨테이너 로그 확인
# -c 옵션으로 컨테이너명 지정
kubectl logs blue-green-app -c blue-app
kubectl logs blue-green-app -c green-app

# 컨테이너 환경변수 확인
# -c 옵션으로 컨테이너명 지정
# env 로 모든 환경 변수 확인 / printenv 로 전체 혹은 특정 환경 변수 확인
kubectl exec blue-green-app -c blue-app -- env
kubectl exec blue-green-app -c blue-app -- printenv POD_IP NAMESPACE NODE_NAME


# Pod 내 컨테이너 간 통신 확인
# 컨테이너간 통신은 port 로 통신한다 - 컨테이너간 포트 충돌 주의
kubectl exec blue-green-app -c blue-app -- curl -vs localhost:8081/hello
kubectl exec blue-green-app -c green-app -- curl -vs localhost:8080/hello

# Pod의 특정 정보만 확인하기
kubectl get pod/red-app -o jsonpath="{.status.podIP}"

# 환경 변수 등록 / 확인
export RED_APP_IP=$(kubectl get pod/red-app -o jsonpath="{.status.podIP}")
echo $RED_APP_IP

# 파드간 통신
kubectl exec blue-green-app -c blue-app -- curl -vs $RED_APP_IP:8080/hello

# 로컬 머신 통신을 위한 포트 포워딩
kubectl port-forward blue-green-app 8080:8080
kubectl port-forward blue-green-app 8081:8081
kubectl port-forward red-app 8082:8080

# 자원 정리
kubectl delete pod --all
