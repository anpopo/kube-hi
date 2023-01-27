# deploymen 의 상태 정보 확인 워치 모드
kubectl get deployment -w

# deployment 배포
kubectl apply -f deployment/deployment_recreate.yaml

# deployment 의 rollout 상태 확인 -> deployment "my-app" successfully rolled out
kubectl rollout status deployment/my-app

# 이미지 변경 -> 프로세스 실행 즉시 파드에 대한 재배포
kubectl set image deployment/my-app my-app=yoonjeong/my-app:2.0

# strategy type 에 Recreate 는 기존에 실행중이던 이전 버전의 파드에 대해서 모두 삭제 후 새로운 버전의 파드를 생성하기 때문에 서비스 다운 타임이 발생한다.

kubectl delete all -l app=my-app
