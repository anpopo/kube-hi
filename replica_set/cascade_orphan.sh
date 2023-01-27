# 레플리카셋 오브젝트 매니페스트 등록
kubectl apply -f replica_set/replica_set.yaml

# 파드의 소유자 정보 확인
kubectl get pod <pod-name> -o jsonpath="{.metadata.ownerReferences[0].name}"

# 레플리카 셋 삭제 (--casecade=orphan 고아 전략)
kubectl delete rs/blue-replicaset --cascade=orphan

# 파드 와 레플리카셋 확인
kubectl get pod
kubectl get rs

# 파드 소유자 정보 확인
kubectl get pod <pod-name> -o jsonpath="{.metadata.ownerReferences[0].name}"

# 파드의 라벨 제거
kubectl label pod/<pod-name> app-

# 레플리카셋 오브젝트 매니페스트
kubectl apply -f replica_set/replica_set.yaml

# 라벨 제거한 파드의 소유자 확인 - 라벨을 제거했기 때문에 replicaset 의 selector 로 관리되지 않는다.
kubectl get pod <pod-name> -o jsonpath="{.metadata.ownerReferences[0].name}"

# 라벨을 제거하지 않은 파드의 소유자 확인
kubectl get pod <pod-name> -o jsonpath="{.metadata.ownerReferences[0].name}"

# 자원 정리
kubectl delete rs --all
kubectl delete pod --all