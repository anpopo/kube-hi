# 레플리카셋 조회 워치 모드
kubectl get rs -w

# deployment 오브젝트 생성
kubectl apply -f deployment/deployment_rolling_update.yaml

# 이미지 변경
kubectl set image deployment/my-app my-app=yoonjeong/my-app:2.0  # 레플리카 재 생성 -> 이전 레플리카는 삭제되지 않음!! 주의

# revision 목록 조회 -> 배포 기록 확인
kubectl rollout history deployment/my-app
kubectl rollout history deployment/my-app --revision=1  # 특정 revision 정보 조회

# 롤백 사유 주석 남기기
kubectl annotate deployment/my-app kubernetes.io/change-cause="image version update to v2"     

# 이전 버전 (revision 명시가 없는 경우) 혹은 특정 revision 으로 롤백
kubectl rollout undo deployment/my-app
kubectl rollout undo deployment/my-app --to-revision=1

# 롤백 사유 주석 남기기
kubectl annotate deployment/my-app kubernetes.io/change-cause="image rollback to revision 1 due to bugs"

# 셀렉터를 이용해 생성된 자원 확인하기
kubectl get all -l app=my-app

# 셀렉터를 이용한 자원 삭제
kubectl delete all -l app=my-app

# 롤링 업데이트 확인 maxUnavailable 과 maxSurge 의 값이 어떻게 반영되어 배포되는가.

# 새로운 레플리카셋 - 74df985bfb
# 삭제할 레플리카셋 - 55cd676547
# NAME                DESIRED   CURRENT   READY   AGE
# my-app-74df985bfb   0         0         0       3m31s
# my-app-74df985bfb   2         0         0       3m31s -> maxSurge: 2       => DESIRED = 0 -> 2
# my-app-55cd676547   2         3         3       2m12s -> maxUnavailable: 1 => DESIRED = 3 -> 2
# my-app-55cd676547   2         3         3       2m12s
# my-app-74df985bfb   3         0         0       3m31s
# my-app-74df985bfb   3         0         0       3m31s
# my-app-55cd676547   2         2         2       2m12s
# my-app-74df985bfb   3         2         0       3m31s
# my-app-74df985bfb   3         3         0       3m31s
# my-app-74df985bfb   3         3         1       3m37s
# my-app-55cd676547   1         2         2       2m18s
# my-app-55cd676547   1         2         2       2m18s
# my-app-55cd676547   1         1         1       2m18s
# my-app-74df985bfb   3         3         2       3m38s
# my-app-55cd676547   0         1         1       2m19s
# my-app-55cd676547   0         1         1       2m19s
# my-app-55cd676547   0         0         0       2m19s
# my-app-74df985bfb   3         3         3       3m41s
