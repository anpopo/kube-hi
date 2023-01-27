# deployment 확인하기 워치 모드
kubectl get deployment -w

# deployment 오브젝트 생성
kubectl apply -f deployment/deployment.yaml

# deployment 배포 상태 확인하기
kubectl rollout status deployment/my-app

# 레플리카셋의 정보 확인 -> pod-template-hash=85598648b8 디플로이먼트를 이용해 생성한 자원들에 pod-template-hash 라벨을 설정 함
kubectl get rs --show-labels

# deployment 의 파드 replicas 변경
kubectl scale deployment <deployment-name> --replicas=<number>

# 레플리카셋의 정보 확인 -> pod-template-hash=85598648b8 replicas 를 변경해도 디플로이가 레플리카셋을 새로 생성하지 않는다.
kubectl get rs --show-labels

# 레플리카셋의 파트생성 이벤트 확인해보기
kubectl describe rs <replicaset-name>

# deployment pod template 의 이미지 변경
kubectl set image deployment/my-app my-app-c=yoonjeong/my-app:2.0

# deployment 의 이벤트 확인
kubectl describe deployment/my-app

# replicaset 과 pod 에 할당된 label 확인 -> 기존 pod-template-hash=85598648b8 과 다름, 즉 템플릿의 해시가 달라지는 경우 replicaset 을 재배포 하는구나!! 아하!
kubectl get rs --show-labels
kubectl get pod --show-labels

# 라벨 셀렉터를 이용한 자원 제거
kubectl delete all -l app=my-app