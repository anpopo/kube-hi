# 레플리카 셋 오브젝트 생성 매니페스트
kubectl apply -f replica_set/replica_set.yaml

# 레플리카셋 정보 확인
kubectl get rs blue-replicaset -o wide

# 레플리카셋으로 생성된 파드 정보 확인
kubectl get pod -w

# 레플리카 셋이 생성해준 파드 삭제
kubectl delete pod <pod-name>

# 레플리카 셋에서 발생한 이벤트 확인
kubectl describe rs blue-replicaset

# 자원 정리
kubectl delete rs --all