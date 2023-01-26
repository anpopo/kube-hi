# 노드 목록 조회
kubectl get node

# 노드에 라벨 추가
kubectl label node <첫번째 노드 이름> <세번째 노드 이름> soil=moist
kubectl label node <두번째 노드 이름> soil=dry

# 노드 조회
kubectl get node -L soil

# 반복문을 돌며 노드에 파드 생성
for i in {1..5};
do kubectl run tree-app-$i \
--labels="element=tree" \
--image=yoonjeong/green-app:1.0 \
--port=8081 \
--overrides='{ "spec" : { "nodeSelector": { "soil": "moist" } } }';
done

# Pod 조회 - 배포된 노드 확인
kubectl get pod -o wide --show-labels

# 라벨을 이용한 자원 정리
kubectl delete pod -l element