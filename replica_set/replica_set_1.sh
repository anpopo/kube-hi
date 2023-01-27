# replicaset 생성 object manifest
kubectl apply -f ./replica_set/replica_set.yaml

# 레플리카 셋 조회
kubectl get rs blue-replicaset -o wide

# 생성된 파드 조회
kubectl get pod -o wide

# 레플리카 셋의 상세 정보 확인
kubectl describe rs blue-replicaset

# 이벤트 발생 내역 조회
kubectl get events --sort-by=.metadata.creationTimestamp

# 레플리카 셋에 의해 생성된 첫번째 파드로 포트 포워딩 (레플리카셋은 로드밸런싱의 기능이 없음)
kubectl port-forward rs/blue-replicaset 8080:8080

# 조회
kubectl exec rs/blue-replicaset -- curl -vs localhost:8080/sky

# 레플리카 셋이 관리하는 파드의 갯수를 1개로 줄임
kubectl scale rs/blue-replicaset --replicas 1

# 파드 삭제 이벤트 확인
kubectl describe rs/blue-replicaset

# 레플리카셋 관리 파드 3개로 확장
kubectl scale rs/blue-replicaset --replicas 3

# 파드 생성 이벤트 확인
kubectl describe rs/blue-replicaset

# 자원 정리
kubectl delete rs --all

