# Pod 생성
kubectl apply -f hello-env.yaml

# Pod 실행 및 IP 확인
kubectl get pod -o wide
kubectl get pod/hello-env -o json

# 컨테이너 IP 확인
kubectl exec hello-env -- ipconfig eth0
kubectl exec hello-env -- cat /etc/hosts

# 컨테이너 설정 환경변수 확인 (env)
kubectl exec hello-env -- env

# 컨테이너 리스닝 포트 확인
kubectl exec hello-env -- netstat -an

# 로컬 포트 포워딩 (8088 -> 8080)
kubectl port-forward hello-env 8088:8080

# 응답 확인
curl -v localhost:8088

# Pod 종료 (자원 정리)
kubectl delete pod --all
kubectl delete pod hello-env