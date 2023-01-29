kubectl apply -f probe/service.yaml

# external ip 생성 확인
kubectl get svc -o wide

kubectl get endpoints -w

kubectl apply -f probe/rediness_probe.yaml

# unhealthy pod ready 상태가 1로 올라오지 않음
kubectl get pod -w

# Readiness probe failed 이벤트 확인
kubectl describe pod/unhealthy

# ready 상태 up, endpoints 에 pod ip 등록
kubectl exec pod/unhealthy -- mkdir /var/ready

# ready 상태 down, endpoints 에 pod ip 제거
kubectl exec pod/unhealthy -- rm -rf /var/ready

# readiness probe 에 설정된 값을 kubelet 이 확인해 컨테이너가 요청에 응답할 수 있는 상태인지를 확인하고 엔트포인트의 pod ip 를 관리한다.

# 자원 정리
kubectl delete all -l app=myapp
kubectl delete svc/myapp
