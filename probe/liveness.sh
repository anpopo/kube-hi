kubectl apply -f probe/liveness_probe.yaml

kubectl get pod -w

# liveness probe failed 이벤트 확인 - kubelet 이 liveness probe 설정을 확인하여 상태가 좋지 않은 경우 컨테이너를 재시작 시킨다.
kubectl describe pod unhealthy 

kubectl delete all -l app=myapp